require 'matrix'
require 'tf-idf-similarity'

class Post < ApplicationRecord
  belongs_to :source
  belongs_to :category
  has_many :bookmarks
  has_many :views
  has_many :likes
  has_many :reports

  LATEST_NEWS_LIMIT = 8
  FROM_SOURCE_LIMIT = 4
  FROM_CATEGORY_LIMIT = 4

  scope :active, -> { where(status: 1) }
  scope :latest, -> { includes(:source, :category).order(publish_date: :desc).limit(LATEST_NEWS_LIMIT) }
  scope :from_source, -> (source_id) { 
    includes(:source, :category).where(source_id: source_id).order(publish_date: :desc)
  }
  scope :from_category, -> (category_id) { 
    includes(:source, :category).where(category_id: category_id).order(publish_date: :desc)
  }
  scope :bookmarked_by, -> (user_id) {
    joins(:bookmarks).where('bookmarks.user_id = ?', user_id).order(publish_date: :desc)
  }
  scope :most_viewed_daily, -> () {
    where(publish_date: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).where('view_count > ?', 0).order('view_count DESC')
  }

  def like_count
    Like.where(post_id: id).count
  end

  def bookmark_count
    Bookmark.where(post_id: id).count
  end

  def score
    view_count + bookmark_count * 2 + like_count * 3
  end

  def soup
    stop_word = Settings.vietnamese_stopwords
    processed_title = title.gsub(/[[:space:]]/, ' ').split(" ") - stop_word
    processed_description = description.gsub(/[[:space:]]/, ' ').split(" ") - stop_word
    soup = processed_title.concat processed_description
    soup.uniq.join(" ")
  end

  class << self
    def can_view_by(user_id)
      reported_posts_id = Report.where(user_id: user_id).pluck(:post_id)
      can_view_post = Post.where.not(id: reported_posts_id)
      can_view_post
    end

    def recommend_posts(session_posts)
      return unless session_posts.present?
      Rails.cache.fetch("recommend_posts", expires_in: 1.hours) do
        posts = Post.where('publish_date > ?', 3.hours.ago).or(where(id: session_posts))
        n_posts = posts.count
        corpus = []
        posts.each do |post|
          corpus << TfIdfSimilarity::Document.new(post.soup)
        end
        model = TfIdfSimilarity::TfIdfModel.new(corpus)
        matrix = model.similarity_matrix

        visited_post_vector = Vector.zero(n_posts)
        visited_posts = Post.where(id: session_posts)
        n_visited_posts = visited_posts.count
        visited_posts.each do |post|
          visited_post_vector += matrix.row(model.text_index(post.soup))
        end

        original_indices = visited_post_vector.to_a.map.with_index.sort.map(&:last).reverse.drop(n_visited_posts)
        recommend_posts = []
        original_indices.each do |i|
          recommend_posts << posts[i]
        end
        recommend_posts
      end
    end
  end
end

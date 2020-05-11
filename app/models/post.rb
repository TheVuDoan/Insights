require 'matrix'
require 'tf-idf-similarity'

class Post < ApplicationRecord
  belongs_to :source
  belongs_to :category
  has_many :bookmarks
  has_many :views
  has_many :likes

  LATEST_NEWS_LIMIT = 8
  FROM_SOURCE_LIMIT = 4
  FROM_CATEGORY_LIMIT = 4

  scope :latest, -> { includes(:source, :category).order(publish_date: :desc).limit(LATEST_NEWS_LIMIT) }
  scope :from_source_with_limit, -> (source_id) { 
    includes(:source, :category).where(source_id: source_id).order(publish_date: :desc).limit(FROM_SOURCE_LIMIT)
  }
  scope :from_category_with_limit, -> (category_id) { 
    includes(:source, :category).where(category_id: category_id).order(publish_date: :desc).limit(FROM_CATEGORY_LIMIT)
  }
  scope :from_source, -> (source_id) { 
    includes(:source, :category).where(source_id: source_id).order(publish_date: :desc)
  }
  scope :from_category, -> (category_id) { 
    includes(:source, :category).where(category_id: category_id).order(publish_date: :desc)
  }
  scope :bookmarked_by, -> (user_id) {
    joins(:bookmarks).where('bookmarks.user_id = ?', user_id).order(publish_date: :desc)
  }
  scope :most_recently_visited_source, -> (session_posts) {
    includes(:source, :category).where(id: session_posts).group(:source_id).order('count(source_id) DESC').first
  }
  scope :most_recently_visited_category, -> (session_posts) {
    includes(:source, :category).where(id: session_posts).group(:category_id).order('count(category_id) DESC').first
  }

  def soup
    stop_word = Settings.vietnamese_stopwords
    processed_title = title.gsub(/[[:space:]]/, ' ').split(" ") - stop_word
    processed_description = description.gsub(/[[:space:]]/, ' ').split(" ") - stop_word
    soup = processed_title.concat processed_description
    soup.uniq.join(" ")
  end

  class << self
    def recommend_posts(session_posts)
      posts = Post.where('publish_date > ?', 2.hours.ago).or(where(id: session_posts))
      n_posts = posts.count
      corpus = []
      posts.each do |post|
        corpus << TfIdfSimilarity::Document.new(post.soup)
      end
      model = TfIdfSimilarity::TfIdfModel.new(corpus)
      matrix = model.similarity_matrix

      visited_post_vector = Vector.zero(n_posts)
      visited_posts = Post.where(id: session_posts)
      visited_posts.each do |post|
        visited_post_vector += matrix.row(model.text_index(post.soup))
      end

      original_indices = visited_post_vector.to_a.map.with_index.sort.map(&:last).reverse.first(13).drop(3)
      recommend_posts = []
      original_indices.each do |i|
        recommend_posts << posts[i]
      end
      recommend_posts
    end
  end
end

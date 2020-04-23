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
end

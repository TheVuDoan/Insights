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
  scope :from_source, -> (source_id) { 
    includes(:source, :category).where(source_id: source_id).order(publish_date: :desc).limit(FROM_SOURCE_LIMIT)
  }
  scope :from_category, -> (category_id) { 
    includes(:source, :category).where(category_id: category_id).order(publish_date: :desc).limit(FROM_CATEGORY_LIMIT)
  }
end

class Post < ApplicationRecord
  belongs_to :source
  belongs_to :category
  has_many :bookmarks
  has_many :views
  has_many :likes

  LATEST_NEWS_LIMIT = 8
  NEW_POST_TIME_LIMIT = 2 # hours

  scope :latest, -> { includes(:source, :category).order(publish_date: :desc).limit(LATEST_NEWS_LIMIT) }
  scope :from_source, -> (source_id) { where(source_id: source_id) }
end

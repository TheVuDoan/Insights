class Post < ApplicationRecord
  belongs_to :source
  belongs_to :category
  has_many :bookmarks
  has_many :views

  LATEST_NEWS_LIMIT = 8
  scope :lastest, -> { includes(:source, :category).order(publish_date: :desc).limit(LATEST_NEWS_LIMIT) }
end

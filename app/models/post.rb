class Post < ApplicationRecord
  belongs_to :source
  has_many :bookmarks

  scope :lastest, -> { includes(:source).order(publish_date: :desc).limit(10) }
end

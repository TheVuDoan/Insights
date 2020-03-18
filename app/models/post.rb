class Post < ApplicationRecord
  belongs_to :source

  scope :lastest, -> { includes(:source).order(publish_date: :desc).limit(10) }
end

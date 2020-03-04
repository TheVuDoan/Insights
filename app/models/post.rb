class Post < ApplicationRecord
    scope :lastest, -> { order(publish_date: :desc).limit(10) }
end

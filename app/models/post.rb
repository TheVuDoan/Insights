class Post < ApplicationRecord
    scope :lastest, -> { order(created_at: :desc)}
end

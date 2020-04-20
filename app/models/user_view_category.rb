class UserViewCategory < ApplicationRecord
  belongs_to :user
  belongs_to :category

  scope :most_visted_by_user, -> (user_id) {
    includes(:category).where(
      user_id: user_id,
      count: UserViewCategory.where(user_id: user_id).maximum(:count)
    )
  }
end

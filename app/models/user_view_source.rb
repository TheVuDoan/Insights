class UserViewSource < ApplicationRecord
  belongs_to :user
  belongs_to :source

  scope :most_visted_by_user, -> (user_id) {
    includes(:source).where(
      user_id: user_id,
      count: UserViewSource.where(user_id: user_id).maximum(:count)
    )
  }
end

class Category < ApplicationRecord
  has_many :user_view_categories
  class << self
    def most_recently_visited (session_posts)
      recent_posts = Post.where(id: session_posts).pluck(:category_id)
      category_id = recent_posts.max_by {|i| recent_posts.count(i)}
      most_visted_category = Category.find(category_id)
      most_visted_category
    end

    def most_visited_by_user (user_id)
      category_id = UserViewCategory.where(user_id: user_id).order(count: :desc)&.first&.category_id
      if category_id.present?
        most_view_category = Category.find(category_id)
        most_view_category
      else
        offset = rand(Category.count) + 1
        most_view_category = Category.find(offset)
        most_view_category
      end
    end
  end
end

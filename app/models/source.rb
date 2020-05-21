class Source < ApplicationRecord
  has_many :user_view_sources
  class << self
    def most_recently_visited (session_posts)
      recent_posts = Post.where(id: session_posts).pluck(:source_id)
      source_id = recent_posts.max_by {|i| recent_posts.count(i)}
      most_visted_source = Source.find(source_id)
      most_visted_source
    end

    def most_visited_by_user (user_id)
      source_id = UserViewSource.where(user_id: user_id).order(count: :desc)&.first&.source_id
      if source_id.present?
        most_view_source = Source.find(source_id)
        most_view_source
      else
        offset = rand(Source.count) + 1
        most_view_source = Source.find(offset)
        most_view_source
      end
    end
  end
end

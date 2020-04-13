class StaticPagesController < ApplicationController
  def home
    @posts = Post.latest

    @most_visited_source = Source.find(UserViewSource.most_visted_by_user(current_user.id).source_id) if user_signed_in?
    @most_visited_source_posts = Post.from_source(@most_visited_source.id).latest if user_signed_in?
  end
end

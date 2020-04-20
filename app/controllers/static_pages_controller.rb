class StaticPagesController < ApplicationController
  def home
    @posts = Post.latest

    if user_signed_in?
      @most_visited_source = UserViewSource.most_visted_by_user(current_user.id)&.first&.source
      @most_visited_source_posts = Post.from_source(@most_visited_source&.id)
    end

    if user_signed_in?
      @most_visited_category = UserViewCategory.most_visted_by_user(current_user.id)&.first&.category
      @most_visited_category_posts = Post.from_category(@most_visited_category&.id)
    end

    @videos = YoutubeVideo.recent_highest_score

    @categories = Category.all
  end
end

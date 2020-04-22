class StaticPagesController < ApplicationController
  def home
    set_post_data
    set_most_visited_data
    set_video_data
  end

  private

  def set_post_data
    @posts = Post.latest
  end

  def set_most_visited_data
    if user_signed_in?
      @most_visited_source = UserViewSource.most_visted_by_user(current_user.id)&.first&.source
      @most_visited_source_posts = Post.from_source(@most_visited_source&.id)
      @most_visited_category = UserViewCategory.most_visted_by_user(current_user.id)&.first&.category
      @most_visited_category_posts = Post.from_category(@most_visited_category&.id)
    elsif session[:recent_posts].present?
      @most_visited_source = Post.most_recently_visited_source(session[:recent_posts]).source
      @most_visited_source_posts = Post.from_source(@most_visited_source&.id)
      @most_visited_category = Post.most_recently_visited_source(session[:recent_posts]).category
      @most_visited_category_posts = Post.from_category(@most_visited_category&.id)
    end
  end

  def set_video_data
    @videos = YoutubeVideo.recent_highest_score
  end
end

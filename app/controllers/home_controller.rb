class HomeController < ApplicationController
  def home
    set_post_data
    set_recommend_post_data
    set_most_visited_data
    set_video_data
  end

  private

  def set_post_data
    @posts = Post.latest
  end

  def set_recommend_post_data
    @recommend_posts = Post.recommend_posts(session[:recent_posts])&.first(6)
  end

  def set_most_visited_data
    if user_signed_in?
      @most_visited_source = Source.most_visited_by_user(current_user.id)
      @most_visited_category = Category.most_visited_by_user(current_user.id)
    elsif session[:recent_posts].present?
      @most_visited_source = Source.most_recently_visited(session[:recent_posts])
      @most_visited_category = Category.most_recently_visited(session[:recent_posts])
    else
      offset_source = rand(Source.count) + 1
      @most_visited_source = Source.find(offset_source)
      offset_category = rand(Category.count) + 1
      @most_visited_category = Category.find(offset_category)
    end

    @most_visited_source_posts = Post.from_source_with_limit(@most_visited_source&.id)
    @most_visited_category_posts = Post.from_category_with_limit(@most_visited_category&.id)
  end

  def set_video_data
    @videos = YoutubeVideo.recent_highest_score
  end
end

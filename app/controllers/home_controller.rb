class HomeController < ApplicationController
  FROM_SOURCE_LIMIT = 4
  FROM_CATEGORY_LIMIT = 3
  def home
    set_post_data
    set_recommend_post_data
    set_most_visited_data
    set_most_viewed_data
    set_video_data
  end

  private

  def set_post_data
    if user_signed_in?
      @posts = Post.active.can_view_by(current_user.id).latest
    else
      @posts = Post.active.latest
    end
  end

  def set_recommend_post_data
    if user_signed_in?
      @recommend_posts = Post.active.recommend_posts_for_user(current_user.id)&.first(6)
    else
      @recommend_posts = Post.active.recommend_posts(session[:recent_posts])&.first(6)
    end
  end

  def set_most_viewed_data
    @most_viewed_daily = Post.active.most_viewed_daily.first(4)
  end

  def set_most_visited_data
    if user_signed_in?
      @most_visited_source = Source.most_visited_by_user(current_user.id)
      @most_visited_category = Category.most_visited_by_user(current_user.id)
      @most_visited_source_posts = Post.active.can_view_by(current_user.id).from_source(@most_visited_source&.id).limit(FROM_SOURCE_LIMIT)
      @most_visited_category_posts = Post.active.can_view_by(current_user.id).from_category(@most_visited_category&.id).limit(FROM_CATEGORY_LIMIT)
    elsif session[:recent_posts].present?
      @most_visited_source = Source.most_recently_visited(session[:recent_posts])
      @most_visited_category = Category.most_recently_visited(session[:recent_posts])
      @most_visited_source_posts = Post.active.from_source(@most_visited_source&.id).limit(FROM_SOURCE_LIMIT)
      @most_visited_category_posts = Post.active.from_category(@most_visited_category&.id).limit(FROM_CATEGORY_LIMIT)
    else
      offset_source = rand(Source.count) + 1
      @most_visited_source = Source.find(offset_source)
      offset_category = rand(Category.count) + 1
      @most_visited_category = Category.find(offset_category)
      @most_visited_source_posts = Post.active.from_source(@most_visited_source&.id).limit(FROM_SOURCE_LIMIT)
      @most_visited_category_posts = Post.active.from_category(@most_visited_category&.id).limit(FROM_CATEGORY_LIMIT)
    end
  end

  def set_video_data
    @videos = YoutubeVideo.recent_highest_score
  end
end

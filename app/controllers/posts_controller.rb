class PostsController < ApplicationController
  def index
    if params[:s].nil?
      @posts = Post.all.order(publish_date: :desc).page(params[:page]).per(20)
    else
      search_param = params[:s]
      @posts = Post.search(title_or_description_cont: search_param).result.includes(:source, :category).page(params[:page]).per(20)
    end
  end

  def recommend
    if user_signed_in?
      @posts = Kaminari.paginate_array(Post.recommend_posts_for_user(current_user.id)).page(params[:page]).per(20)
    else
      @posts = Kaminari.paginate_array(Post.recommend_posts(session[:recent_posts])).page(params[:page]).per(20)
    end
  end
end

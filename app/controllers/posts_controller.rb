class PostsController < ApplicationController
  def index
    if params[:s].nil?
      @posts = Post.all.order(publish_date: :desc).page(params[:page]).per(20)
    else
      search_param = params[:s]
      @posts = Post.search(title_or_description_cont: search_param).result.includes(:source, :category).page(params[:page]).per(20)
    end
  end
end

class PostsController < ApplicationController
  def index
    @posts = Post.all.order(publish_date: :desc).page(params[:page]).per(20)
  end
end

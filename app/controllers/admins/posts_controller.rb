module Admins
  class PostsController < BaseController
    def index   
      @posts = Post.includes(:category, :source).all.order(id: :desc).page(params[:page]).per(20)
    end 
  end
end

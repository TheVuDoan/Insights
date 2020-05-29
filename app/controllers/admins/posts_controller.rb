module Admins
  class PostsController < BaseController  
    def index   
      @posts = Post.includes(:category, :source).all.order(id: :desc).page(params[:page]).per(20)
    end

    def show
      @post = Post.find(params[:id])
    end

    def destroy   
      post = Post.find(params[:id])   
      if post.delete   
        respond_to do |format|
          format.html { redirect_back(fallback_location: admins_posts_path) }
          format.json { head :no_content }
        end
      end   
    end   

    def toggle
      post_id = params[:id]
      post = Post.find(post_id)
      if post.present?
        post.status = !post.status
        post.save
      end
      respond_to do |format|
        format.html { redirect_back(fallback_location: admins_posts_path) }
        format.json { head :no_content }
      end
    end
  end
end

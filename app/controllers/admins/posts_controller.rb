module Admins
  class PostsController < BaseController  
    def index
      @q = Post.ransack(params[:q])
      @posts = @q.result.includes(:category, :source).order(id: :desc).page(params[:page]).per(20)
      @sources = Source.all
      @categories = Category.all
    end

    def show
      @post = Post.includes(:category, :source).find(params[:id])
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

    private

    def post_params
      params.require(:q).permit(:title, :description, :publish_date, :status, :source_id, :category_id)
    end
  end
end

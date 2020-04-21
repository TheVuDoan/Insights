class BookmarksController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    if !user_signed_in?
      redirect_to '/users/sign_in', alert: "Đăng nhập để sử dụng chức năng!"
    else 
      @bookmarked_posts = Post.bookmarked_by(current_user.id).page(params[:page]).per(20)
    end
  end

  def create
    if !user_signed_in?
      redirect_to '/users/sign_in', alert: "Đăng nhập để sử dụng chức năng!"
    else 
      post_id = params[:post_id]
      bookmark = Bookmark.where(post_id: post_id, user_id: current_user.id).first
      if bookmark.nil?
        bookmark = Bookmark.create(post_id: post_id, user_id: current_user.id, status: 1)
      else
        bookmark.status = !bookmark.status
        bookmark.save
      end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:post_id)
  end
end

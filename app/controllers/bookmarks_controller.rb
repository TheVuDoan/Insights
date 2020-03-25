class BookmarksController < ApplicationController
  def index
    @post = Post.includes(bookmark: :user).where(user_id: current_user.id) if user_signed_in?
  end

  def create
    post_id = params[:post_id]
    bookmark = Bookmark.where(post_id: post_id, user_id: current_user.id).first
    if bookmark.nil?
      bookmark = Bookmark.create(post_id: post_id, user_id: current_user.id, status: 1)
    else
      bookmark.status = !bookmark.status
      bookmark.save
    end
    # respond_to do |format|
    #   format.json { head :no_content }
    #   format.js   { render :layout => false }
    # end
  end

  private

  def bookmark_params
    params.require(:bookmark).permit(:post_id)
  end
end

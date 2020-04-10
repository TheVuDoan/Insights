class LikesController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if !user_signed_in?
      redirect_to '/users/sign_in', alert: "Đăng nhập để sử dụng chức năng!"
    else 
      post_id = params[:post_id]
      like = Like.where(post_id: post_id, user_id: current_user.id).first
      if like.nil?
        like = Like.create(post_id: post_id, user_id: current_user.id)
      else
        like.destroy
      end
    end
  end
end

class ViewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  def create
    if user_signed_in?
      post_id = params[:post_id]
      rate = params[:rate]
      view = View.where(post_id: post_id, user_id: current_user.id).first
      if view.nil?
        view = View.create(post_id: post_id, user_id: current_user.id, count: 1)
      else
        view.count = view.count + 1
        view.save
      end
    end
  end
end

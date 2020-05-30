module Admins
  class UsersController < BaseController  
    def index
      @q = User.ransack(params[:q])
      @users = @q.result.order(id: :desc).page(params[:page]).per(20)
    end
  end
end
  
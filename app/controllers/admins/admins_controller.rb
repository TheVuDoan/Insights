module Admins
  class AdminsController < BaseController  
    def index
      @q = Admin.ransack(params[:q])
      @admins = @q.result.includes(:role).order(id: :desc).page(params[:page]).per(20)
    end
  end
end

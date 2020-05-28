class Admins::BaseController < ApplicationController
  layout "simple_layout"
  before_action :ensure_admin_user!

  def ensure_admin_user!
    unless current_admin
      redirect_to '/admins/sign_in/'
    end
  end
end
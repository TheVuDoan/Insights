class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :layout_by_user_types # works like a before action 
  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :password, :password_confirmation, :fullname, :role_id])
  end
  
  def after_sign_in_path_for(resource)
    request.env['omniauth.origin'] || stored_location_for(resource) || root_url
  end

  def layout_by_user_types
    if current_admin
      "admins/application"
    else
      "application"
    end
  end
end

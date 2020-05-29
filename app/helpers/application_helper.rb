module ApplicationHelper
  include Admins::PostsHelper
  include DeviseHelper

  def active_class(controller_name, action_name)
    current_page?(controller: controller_name, action: action_name) ? 'active' : ''
  end
end

module Admins
  class DashboardController < BaseController
    def index
      @num_of_user = User.count
    end

    private
  end
end
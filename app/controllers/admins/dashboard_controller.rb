module Admins
  class DashboardController < ApplicationController
    layout "simple_layout"
    def index
      @hi = "hi"
    end

    private
  end
end
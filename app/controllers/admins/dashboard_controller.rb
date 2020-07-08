module Admins
  class DashboardController < BaseController
    def index
      @num_of_user = User.count
      @num_of_post = Post.count
      @num_of_video = YoutubeVideo.count
    end

    private
  end
end
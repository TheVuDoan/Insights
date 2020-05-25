class YoutubeVideosController < ApplicationController
  def index
    @videos = YoutubeVideo.latest.page(params[:page]).per(15)
  end
end

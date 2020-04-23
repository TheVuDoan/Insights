class YoutubeVideosController < ApplicationController
  def index
    @videos = YoutubeVideo.sort_by_highest_score.page(params[:page]).per(15)
  end
end

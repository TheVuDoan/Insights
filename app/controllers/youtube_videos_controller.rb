class YoutubeVideosController < ApplicationController
  def index
    @videos = Kaminari.paginate_array(YoutubeVideo.sort_by_highest_score).page(params[:page]).per(15)
  end
end

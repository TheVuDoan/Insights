module Admins
  class YoutubeVideosController < BaseController  
    def index
      @q = YoutubeVideo.ransack(params[:q])
      @videos = @q.result.order(id: :desc).page(params[:page]).per(20)
      @channels = YoutubeChannel.all
    end

    def show
      @video = YoutubeVideo.find(params[:id])
    end

    def destroy   
      video = YoutubeVideo.find(params[:id])   
      if video.delete   
        respond_to do |format|
          format.html { redirect_back(fallback_location: admins_youtube_videos_path) }
          format.json { head :no_content }
        end
      end   
    end   
  end
end
  
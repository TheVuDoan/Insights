module Admins
  class SourcesController < BaseController  
    def index
      @q = Source.ransack(params[:q])
      @sources = @q.result.page(params[:page]).per(20)
    end

    def show
      @source = Source.find(params[:id])
    end

    def destroy   
      source = Source.find(params[:id])   
      if source.delete   
        respond_to do |format|
          format.html { redirect_back(fallback_location: admins_sources_path) }
          format.json { head :no_content }
        end
      end   
    end
    
    def new   
      @source = Source.new   
    end

    def create   
      @source = Source.new(source_params)   
      if @source.save   
        redirect_to admins_sources_path 
      else   
        render :new   
      end   
    end 

    def edit   
      @source = Source.find(params[:id])   
    end   
     
    def update   
      @source = Source.find(params[:id])   
      if @source.update_attributes(source_params)   
        redirect_to admins_sources_path   
      else   
        render :edit   
      end   
    end   

    private

    def source_params
      params.require(:source).permit(:name, :slug, :url, :logo, :icon)
    end
  end
end
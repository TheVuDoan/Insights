module Admins
  class CategoriesController < BaseController  
    def index
      @q = Category.ransack(params[:q])
      @categories = @q.result.page(params[:page]).per(20)
    end

    def show
      @category = Category.find(params[:id])
    end

    def destroy   
      category = Category.find(params[:id])   
      if category.delete   
        respond_to do |format|
          format.html { redirect_back(fallback_location: admins_categories_path) }
          format.json { head :no_content }
        end
      end   
    end
    
    def new   
      @category = Category.new   
    end

    def create   
      @category = Category.new(category_params)   
      if @category.save   
        redirect_to admins_categories_path 
      else   
        render :new   
      end   
    end 

    def edit   
      @category = Category.find(params[:id])   
    end   
     
    def update   
      @category = Category.find(params[:id])   
      if @category.update_attributes(category_params)   
        redirect_to admins_categories_path   
      else   
        render :edit   
      end   
    end   

    private

    def category_params
      params.require(:category).permit(:name, :slug, :label_type)
    end
  end
end

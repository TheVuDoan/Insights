class CategoriesController < ApplicationController
  def show
    @category = Category.where(slug: params[:slug]).first
    @posts = Post.from_category(@category.id).page(params[:page]).per(20)
  end
end

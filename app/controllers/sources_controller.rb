class SourcesController < ApplicationController
  def show
    @source = Source.where(slug: params[:slug]).first
    @posts = Post.from_source(@source&.id).page(params[:page]).per(20)
  end
end

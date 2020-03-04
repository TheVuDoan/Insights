class StaticPagesController < ApplicationController
  def home
    @posts = Post.lastest
  end
end

class ViewsController < ApplicationController
  skip_before_action :verify_authenticity_token

  SESSION_POST_ARRAY_LIMIT = 5

  def create
    post_id = params[:post_id]
    source_id = Post.find(post_id).source_id
    category_id = Post.find(post_id).category_id

    recent_posts = session[:recent_posts]
    recent_posts ||= Array.new
    recent_posts.push(post_id) unless recent_posts.include?(post_id)
    if recent_posts.count > SESSION_POST_ARRAY_LIMIT
      recent_posts.shift
    end
    session[:recent_posts] = recent_posts

    if user_signed_in?
      view = View.where(post_id: post_id, user_id: current_user.id).first
      if view.nil?
        view = View.create(post_id: post_id, user_id: current_user.id, count: 1)
      else
        view.count = view.count + 1
        view.save
      end

      source_view = UserViewSource.where(source_id: source_id, user_id: current_user.id).first
      if source_view.nil?
        source_view = UserViewSource.create(source_id: source_id, user_id: current_user.id, count: 1)
      else
        source_view.count = source_view.count + 1
        source_view.save
      end

      category_view = UserViewCategory.where(category_id: category_id, user_id: current_user.id).first
      if category_view.nil?
        category_view = UserViewCategory.create(category_id: category_id, user_id: current_user.id, count: 1)
      else
        category_view.count = category_view.count + 1
        category_view.save
      end
    end
  end
end

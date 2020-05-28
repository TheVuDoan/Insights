Rails.application.routes.draw do
  devise_for :admins, path: 'admins', controllers: {
    sessions: 'admins/sessions'
  }
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    passwords: 'users/passwords',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'home#home'
  get 'home/home'
  get '/404', to: 'static_pages#page_not_found'

  resources :posts do
    collection do
      get 'recommend'
    end
  end
  resources :youtube_videos, path: 'videos', as: :youtube_videos, only: [:index]
  resources :categories, param: :slug
  resources :sources, param: :slug
  resources :bookmarks
  resources :reports, only: [:create]
  resources :views, only: [:create]
  resources :likes, only: [:create]

  namespace :admins do
    root "dashboard#index"
  end
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

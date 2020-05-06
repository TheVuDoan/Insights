Rails.application.routes.draw do
  devise_for :users, path: 'users', controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations',
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  root 'home#home'
  get 'home/home'
  
  resources :posts
  resources :youtube_videos, path: 'videos', as: :youtube_videos, only: [:index]
  resources :categories, param: :slug
  resources :sources, param: :slug
  resources :bookmarks
  resources :views, only: [:create]
  resources :likes, only: [:create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

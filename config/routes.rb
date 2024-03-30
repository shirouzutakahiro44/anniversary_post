Rails.application.routes.draw do
  resources :notifications, only: :index
  resources :child_anniversaries do
    resources :child_posts
  end

  devise_for :users, controllers: { 
    omniauth_callbacks: 'users/omniauth_callbacks'
  }
  
  resources :users do
    member do
      get :following, :followers
    end
  end

  resources :relationships, only: [:create, :destroy]
  root 'static_pages#home'
  get :about, to: 'static_pages#about'
  get :use_of_terms, to: 'static_pages#terms'
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
  get :favorites, to: 'favorites#index'
  post   "favorites/:child_post_id/create"  => "favorites#create"
  delete "favorites/:child_post_id/destroy" => "favorites#destroy"
  resources :comments, only: [:create, :destroy]
  get '/child_post/hashtag/:name' => 'child_posts#hashtag'
  get '/child_post/hashtag' => 'child_posts#hashtag'
  # Defines the root path route ("/")
  # root "posts#index"
end

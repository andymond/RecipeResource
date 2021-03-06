Rails.application.routes.draw do
  root to: "welcome#index"

  resources :dashboard, only: [:index]

  resources :notifications, only: [:new, :create]

  resources :users, only: [:new, :create, :edit, :update] do
    resources :favorites, only: [:create, :destroy, :index]
  end

  resources :google_users, only: [:create]
  resources :sessions, only: [:create]
  resources :restaurants, only: [:show, :new, :create], param: :slug do
    resources :recipe_stats, only: [:index]
    resources :recipes, only: [:index, :show], param: :slug do
      resources :recipe_images, only: [:index]
      resources :comments, only: [:create]
    end
  end

  namespace :chef do
    resources :restaurants, only: [:edit, :update], param: :slug do
      resources :recipes, only: [:new, :create, :edit, :update, :destroy], param: :slug do
        resources :recipe_images, only: [:new, :create, :destroy], as: :image
      end
    end
  end

  get "/auth/google", as: :google_login
  get 'auth/:provider/callback',  to: 'gsessions#create'
  get '/logout', to: "sessions#destroy", as: :logout
end

Rails.application.routes.draw do
  root to: "welcome#index"

  resources :dashboard, only: [:index]

  resources :users, only: [:create]
  resources :google_users, only: [:create]
  resources :sessions, only: [:create]
  resources :restaurants, only: [:show, :new, :create], param: :slug do
    resources :recipes, only: [:index, :show], param: :slug
  end
  namespace :chef do
    resources :restaurants, only: [:edit, :update], param: :slug do
      resources :recipes, only: [:new, :create, :edit, :update, :destroy], param: :slug
    end
  end

  get "/auth/google", as: :google_login
  get 'auth/:provider/callback',  to: 'gsessions#create'
  get '/logout', to: "sessions#destroy", as: :logout
end

Rails.application.routes.draw do
  root to: "welcome#index"

  resources :dashboard, only: [:index]

  resources :users, only: [:create]

  get "/auth/google", as: :google_login
  get 'auth/:provider/callback',  to: 'gsessions#create'
  get '/logout', to: "sessions#destroy", as: :logout
end

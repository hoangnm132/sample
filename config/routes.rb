Rails.application.routes.draw do
  root "static_page#home"

  get "sessions/new"
  get "users/new"
  get "users/new"
  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  get "/contact", to: "static_page#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"
  get "password_resets/new"
  get "password_resets/edit"

  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"

  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets, only: %i(new create edit update)
  resources :microposts, only: %i(create destroy)
  resources :relationships, only: %i(create destroy)
  resources :users do
    member do
      get :following, :followers
    end
  end

end


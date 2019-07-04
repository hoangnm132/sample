Rails.application.routes.draw do
  get 'password_resets/new'
  get 'password_resets/edit'
  root "static_page#home"

  get "sessions/new"
  get "users/new"
  get "users/new"
  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  get "/contact", to: "static_page#contact"
  get "/signup", to: "users#new"
  get "/login", to: "sessions#new"

  post "/login", to: "sessions#create"
  post "/signup", to: "users#create"

  delete "/logout", to: "sessions#destroy"

  resources :users
  resources :account_activations, only: %i(edit)
  resources :password_resets, only: %i(new, :create, :edit, :update)
end

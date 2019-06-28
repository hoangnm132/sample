Rails.application.routes.draw do
  root "static_page#home"

  get "users/new"
  get "users/new"
  get "/help", to: "static_page#help"
  get "/about", to: "static_page#about"
  get "/contact", to: "static_page#contact"
  get "/signup", to: "users#new"

  post "/signup", to: "users#create"

  resources :users
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  get "auth/:provider/callback", to: "sessions#create"
  get "/login", to: "sessions#new"
  get "/users/new", to: "users#new"
  post "/users/new", to: "users#create"
  get "/users/signin", to: "users#signin"
  post "/users/login", to: "users#login"
end

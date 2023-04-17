Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "users#index"
  post "auth/developer/callback", to: "users#create_user"
  post "auth/github/callback", to: "users#create_user"

  get "/login", to: "sessions#new"
  get "/users/new", to: "users#new"
  post "/users/new", to: "users#create_user"
  get "/users/signin", to: "users#signin"
  post "/users/login", to: "users#login"
end

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  root "home#index"
  get '/callback', to: 'home#callback'
  get '/show_token', to: 'home#show_token'
end

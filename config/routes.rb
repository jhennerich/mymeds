Rails.application.routes.draw do

  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get '/login', to: 'sessions#new'
  post '/login', to: 'sessions#create'
  delete '/logout', to: 'sessions#destroy'
  get '/signup', to: 'users#new'
  post '/signup', to: 'users#create'
  post 'users', to: 'users#create'

  get '/auth/:provider/callback' => 'sessions#omniauth'
  post '/auth/:provider/callback' => 'sessions#omniauth'
  get "/dashboard", to: "dashboard#show"

end

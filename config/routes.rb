Rails.application.routes.draw do
  root "home#index"

  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new, :create, :destroy]

  get '/signup', to: 'sessions#new'
  get '/sign_out', to: 'sessions#destroy'
  delete '/sign_out', to: 'sessions#destroy'

  get '/auth/:provider/callback' => 'sessions#omniauth'
  post '/auth/:provider/callback' => 'sessions#omniauth'
  get "/dashboard", to: "dashboard#show"

end
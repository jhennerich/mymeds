Rails.application.routes.draw do
 root "home#index"

#  get '/login', to: 'sessions#new'
#  get '/login_via_mail', to: 'sessions#create'
#  post '/login', to: 'sessions#create'

  delete '/logout', to: 'sessions#destroy'

  resources :registrations, only: [:new,:create]
  resources :sessions, only: [:new, :create, :destroy]

  get '/signup', to: 'sessions#new'
  post '/signup', to: 'users#create'

#  post 'users', to: 'users#create'

  get '/auth/:provider/callback' => 'sessions#omniauth'
  post '/auth/:provider/callback' => 'sessions#omniauth'
  get "/dashboard", to: "dashboard#show"

end

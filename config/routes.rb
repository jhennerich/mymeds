Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get '/auth/:provider/callback' => 'sessions#omniauth'
  post '/auth/:provider/callback' => 'sessions#omniauth'
  get "/dashboard", to: "dashboard#show"
  delete '/logout', to: 'sessions#destroy'

end

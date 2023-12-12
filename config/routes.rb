Rails.application.routes.draw do
  get "up" => "rails/health#show", as: :rails_health_check
  root "home#index"

  get '/auth/:provider' => 'sessions#omniauth'
  post '/auth/:provider' => 'sessions#omniauth'
  get "/dashboard", to: "dashboard#show"

end

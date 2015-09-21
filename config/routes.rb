Rails.application.routes.draw do
  get '/ping' => 'main#ping'
  get '/auth/:provider/callback' => 'sessions#create'

  root to: 'haikus#index'
end


Rails.application.routes.draw do
  get '/ping' => 'main#ping'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/sessions/:id' => 'sessions#destroy'

  root to: 'haikus#index'
end


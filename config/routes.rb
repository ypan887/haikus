Rails.application.routes.draw do
  get '/ping' => 'main#ping'
  get '/auth/:provider/callback' => 'sessions#create'
  delete '/sessions/:id' => 'sessions#destroy'
  resources :tags, only: [:create, :update, :destroy], constraints: {format: :json} 

  root to: 'haikus#index'
end


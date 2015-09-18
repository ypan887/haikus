Rails.application.routes.draw do
  get '/ping' => 'main#ping'

  root to: 'haiku#index'
end

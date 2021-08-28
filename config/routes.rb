Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html

  get '/metars', to: 'metars#index'

  resources :airports, only: [:index, :create]
end

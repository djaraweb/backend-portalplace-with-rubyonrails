Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/name_route', to: 'name_controller#name_method'
  
  get '/health', to: 'health#health'
  post '/login', to: 'users#login'

  #get '/properties', to: 'properties#index'
  get '/propertiesforuser', to: 'properties#propertiesforuser'
  get '/property/addvisits/:id', to: 'properties#incrementvisits'
  post '/property/sendemail/:id', to: 'properties#sendemail'
  #delete '/property/destroy/:id', to: 'properties#destroy'

  get 'users/current' => 'users#current'


  resources :properties, only: [:index, :create, :update, :destroy]
  resources :users, only: [:index, :show, :create], defaults: { format: :json }
  resources :posts, only: [:index, :show, :create, :update], defaults: { format: :json } 
end

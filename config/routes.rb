Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  # get '/name_route', to: 'name_controller#name_method'
  
  get '/health', to: 'health#health'

  resources :posts, only: [:index, :show, :create, :update]
end

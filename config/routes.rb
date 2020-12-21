Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      # resources :recipes, only: [:show]
      resources :users, only: [:create, :update, :destroy]
      post '/login', to: 'sessions#create'
      get '/auto_login', to: 'sessions#auto_login'
      get '/user_auth', to: "sessions#user_auth"
      delete '/logout', to: 'sessions#destroy'
      get '/profile', to: 'users#profile'
      resources :carts
      resources :cart_items
      resources :products

      post '/create_session', to: 'checkouts#create_session'
    end
  end
end

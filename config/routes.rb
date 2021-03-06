Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
    namespace :v1 do
      resources :users, only: [:create, :update, :destroy]

      post '/login', to: 'sessions#create'
      get '/auto_login', to: 'sessions#auto_login'
      get '/user_auth', to: "sessions#user_auth"
      delete '/logout', to: 'sessions#destroy'

      resources :carts

      resources :cart_items
      delete '/clear_cart', to: 'cart_items#clear_cart'

      resources :products

      resources :reviews

      post '/create_session', to: 'checkouts#create_session'
      get '/client_secret', to: 'checkouts#client_secret'
    end
  end
end

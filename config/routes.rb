Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  resource :dashboard, only: :show
  resources :products do 
    member do 
      delete :destroy_image
    end
  end
  resource :cart, only: :show do 
    post "add_item/:product_id", to: "carts#add_item", as: 'add_item'
    patch "update_item/:id", to: "carts#update_item", as: "update_item"
    delete "remove_item/:id", to: "carts#remove_item", as: "remove_item"
  end
  resources :orders, only: [:create, :show, :index]
  resource :registration, only: %i[new create]
  resource :session, only: %i[new create destroy]
  resource :password_reset, only: %i[new create edit update]
  resource :password, only: %i[edit update]
  root "pages#home"
end

Rails.application.routes.draw do
  resources :shared_carts, only: [:create]
  get '/shared_carts/:token', to: 'shared_carts#show', as: :shared_cart
  
  devise_for :users
  resources :products
  resources :carts, only: [:index, :show, :create, :destroy]
  # or just index-only if you want:
  # resources :products, only: [:index]
  
  root "products#index" # Optional: make the product list your homepage

  namespace :admin do
    resources :products, only: [] do
      collection do
        get :low_stock
      end
    end
  end
end

Rails.application.routes.draw do
  devise_for :users
  resources :products
  resources :carts, only: [:index, :show, :create, :destroy] do
    member do
      patch :cleanup, to: "cart_cleanups#cleanup"
    end
  end
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

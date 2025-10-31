Rails.application.routes.draw do
  resources :shared_carts, only: [:create]
  get '/shared_carts/:token', to: 'shared_carts#show', as: :shared_cart
  
  devise_for :users
  resources :products
  resources :carts, only: [:index, :show, :create, :destroy] do
    member do
      patch :cleanup, to: "cart_cleanups#cleanup"
      get :intent_suggestions, to: "cart_intents#suggestions"
      get :quantity_suggestions, to: 'adaptive_quantities#suggestions'
      get :trending_items, to: 'cart_trends#trending_items'
    end
  end
  
  root "products#index" # Optional: make the product list your homepage

  namespace :admin do
    resources :products, only: [] do
      collection do
        get :low_stock
      end
    end
  end
end

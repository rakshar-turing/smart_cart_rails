Rails.application.routes.draw do
  devise_for :users
  resources :products
  # or just index-only if you want:
  # resources :products, only: [:index]
  
  root "products#index" # Optional: make the product list your homepage
end

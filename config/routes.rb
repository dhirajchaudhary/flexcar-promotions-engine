Rails.application.routes.draw do
  root "pages#home"

  # Shopping
  post   "/add_to_cart",    to: "carts#add_item",    as: :add_to_cart
  delete "/remove_from_cart", to: "carts#remove_item", as: :remove_from_cart

  # Admin UI
  resources :items,     only: [:new, :create]
  resources :categories, only: [:new, :create]
  resources :brands,    only: [:new, :create]
  resources :promotions, only: [:new, :create]
  
  # Quick links in nav
  get "/admin", to: "admin/dashboard#show", as: :admin_dashboard
end

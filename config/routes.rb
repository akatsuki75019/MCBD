Rails.application.routes.draw do
  root 'static_pages#index'
  
  get 'static_pages/index'
  get 'static_pages/contact'
  
  devise_for :users
  resources :users
  resources :events
  resources :books

  resources :carts, except: [:index, :new, :edit]
  resources :joint_table_cart_books, only: [:index, :create, :update, :destroy]  
  
  get "up" => "rails/health#show", as: :rails_health_check
end

Rails.application.routes.draw do
  get 'join_table_cart_book/create'
  get 'join_table_cart_book/update'
  get 'join_table_cart_book/destroy'
  root 'static_pages#index'
  
  get 'static_pages/index'
  get 'static_pages/contact'
  
  resources :events
  resources :books
  devise_for :users

  resources :carts, except: [:index, :new, :edit]
  resources :join_table_cart_books, only: [:index, :create, :update, :destroy]  
  
  get "up" => "rails/health#show", as: :rails_health_check
end

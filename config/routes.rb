Rails.application.routes.draw do
  root 'static_pages#index'
  
  namespace :admin do
      resources :attendances
      resources :books
      resources :carts
      resources :categories
      resources :editors
      resources :events
      resources :joint_table_cart_books
      resources :joint_table_order_books
      resources :orders
      resources :price_codes
      resources :users
      resources :wishlists

      root to: "attendances#index"
    end
  
  get 'static_pages/index'
  get 'static_pages/contact'
  
  devise_for :users
  resources :users
  resources :events, only: [:show, :index]
  resources :books, only: [:show, :index]

  resources :carts, except: [:index, :new, :edit]
  resources :joint_table_cart_books, only: [:index, :create, :update, :destroy]  

  
  get "up" => "rails/health#show", as: :rails_health_check

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
  
end
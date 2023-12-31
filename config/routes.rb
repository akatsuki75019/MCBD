Rails.application.routes.draw do
  get 'search/show'
  root 'static_pages#index'
  
  namespace :admin do
      resources :users, only: [:index, :show, :edit, :update, :destroy]
      resources :books
      resources :orders, only: [:index, :show, :edit, :update, :destroy]
      resources :carts, only: [:index, :show, :edit, :update, :destroy]
      resources :price_codes
      resources :categories
      resources :editors
      resources :events

      root to: "books#index"
    end
  
  get '/search', to: 'search#show', as: 'search'

  get 'static_pages/index'
  get 'static_pages/contact' 
  get 'static_pages/gdpr'
  get 'static_pages/legal_notice'
  get 'static_pages/terms_and_conditions'

  devise_for :users, controllers: { sessions: 'users/sessions' }
  resources :users
  resources :events, only: [:show, :index]

  
  resources :books, only: [:show] 
  match 'books'=>"books#books_by_category" ,via: [:get, :post]
  

  resources :carts, except: [:index, :new, :edit]
  resources :joint_table_cart_books, only: [:index, :create, :update, :destroy]  

  
  get "up" => "rails/health#show", as: :rails_health_check

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
    post 'express_checkout', to: 'checkout#express_checkout', as: 'express_checkout'
  end

  resources :events do
    member do
      post 'attend', to: 'events#attend'
    end   
  end

  resources :carts do
    collection do
      match 'update_cart', via: [:patch, :post]
    end
  end 

  
end

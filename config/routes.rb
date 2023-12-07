Rails.application.routes.draw do
  root 'static_pages#index'
  
  get 'static_pages/index'
  get 'static_pages/contact'
  
  resources :events
  resources :books
  devise_for :users

  resources :carts, except: [:index, :new, :edit]
  resources :joint_table_cart_books, only: [:index, :create, :update, :destroy]  
  
  get "up" => "rails/health#show", as: :rails_health_check

  scope '/checkout' do
    post 'create', to: 'checkout#create', as: 'checkout_create'
    get 'success', to: 'checkout#success', as: 'checkout_success'
    get 'cancel', to: 'checkout#cancel', as: 'checkout_cancel'
  end
  
end

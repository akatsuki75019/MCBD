Rails.application.routes.draw do
  root 'static_pages#index'
  
  get 'static_pages/index'
  get 'static_pages/contact'
  
  resources :events
  resources :books
  devise_for :users
  
  get "up" => "rails/health#show", as: :rails_health_check
end

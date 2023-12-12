class ApplicationController < ActionController::Base
  before_action :current_user, :current_cart

  def after_sign_in_path_for(resource)
    # Récupérer l'URL stockée 
    stored_location = stored_location_for(resource)
    if stored_location
      stored_location
    else
      root_path
    end
  end

  def current_cart
    if login?
      @cart = current_user.cart || Cart.create(user: current_user)
    else
      if session[:cart]
        @cart = Cart.find(session[:cart])
        
        # Si l'utilisateur est déconnecté mais le panier est associé à un utilisateur, désassociez-le.
        @cart.update(user: nil) if @cart.user.present?
      else
        @cart = Cart.create(user: @user)
        session[:cart] = @cart.id
      end
    end
  end
  

  def login?
    !!current_user
  end
end

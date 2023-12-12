class ApplicationController < ActionController::Base
  before_action :current_user, :current_cart

  def current_user
    @user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def current_cart
    if login?
      @cart = current_user.cart
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

class ApplicationController < ActionController::Base
  before_action :current_user, :current_cart

  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    stored_location || root_path
  end

  #récupérer le panier associé à l'utilisateur connecté ou crée un nouveau panier s'il n'en a pas déjà un. 
  #Si l'utilisateur n'est pas connecté, on essaie de trouver ou de créer un panier basé sur l'ID stocké dans la session.
  def current_cart
    if login?
      @cart = current_user.cart || current_user.create_cart unless session[:cart_id].present?
      session[:cart_id] ||= @cart.id if @cart.present?
    else
      @cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] ||= @cart.id
    end
  end

  def login?
    !!current_user
  end
end

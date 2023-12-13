class ApplicationController < ActionController::Base
  before_action :current_user, :current_cart
  before_action :transfer_cart_items, if: :user_signed_in?

  # Personnalise la redirection après la connexion d'un utilisateur, en le renvoyant soit à la page qu'il a essayé d'accéder avant la connexion
  def after_sign_in_path_for(resource)
    stored_location = stored_location_for(resource)
    stored_location || root_path
  end

  #récupérer le panier associé à l'utilisateur connecté ou crée un nouveau panier s'il n'en a pas déjà un. 
  #Si user non connecté, on essaie de trouver ou de créer un panier basé sur l'ID stocké dans la session.
  def current_cart
    if login?
      @cart = current_user.cart || current_user.create_cart unless session[:cart_id].present?
      session[:cart_id] ||= @cart.id if @cart.present?
    else
      @cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] ||= @cart.id
    end
  end

  #renvoie true si un utilisateur est connecté et false sinon
  def login?
    !!current_user
  end

  private

  def transfer_cart_items
    return unless user_signed_in? && session[:cart_id].present? #on sort de la méthode si l'utilisateur n'est pas connecté OU si le panier dans la session n'est pas présent.
    cart_transfer_service = CartTransferService.new #si les conditions du dessus sont remplies, on créé une nouvelle instance carttransfertservice
    cart_transfer_service.transfer_items(current_user, session[:cart_id], session) #appel de la def transfert_item dans la class du service de transfert avec les paramètres de l'id de session
  end

end

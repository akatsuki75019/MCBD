class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = Cart.find(params[:id])

    #le user est il le propriétaire du panier ? si non, on affiche un message d'erreur : 
    unless current_user == @cart.user
      redirect_to root_path, alert: "Vous n'avez pas les droits pour accéder à cette page."
      return
    end
    
    @total_price = @cart.total_price
    @joint_table_cart_books = @cart.joint_table_cart_books
  end

  def create
    if current_user.cart.persisted? #vérifie si un enregistrement a déjà été enregistré en BDD
      redirect_to root_path, notice: "Le panier de l'utilisateur a bien été créé."
    else
      redirect_to root_path, alert: "Attention : le panier n'a pas été créé."
    end
  end



end

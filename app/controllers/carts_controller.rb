class CartsController < ApplicationController
  before_action :authenticate_user!

  def show
    @cart = current_user.cart
  end

  def create
    if current_user.cart.persisted? #vérifie si un enregistrement a déjà été enregistré en BDD
      redirect_to root_path, notice: "Le panier de l'utilisateur a bien été créé."
    else
      redirect_to root_path, alert: "Attention : le panier n'a pas été créé."
    end
  end



end

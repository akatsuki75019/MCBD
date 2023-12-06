class JoinTableCartBookController < ApplicationController
  def create
    book = Book.(params.fetch(:book_id, nil)) # .fetch = Si la clé :book_id n'est pas présente dans params, la valeur par défaut nil sera utilisée. 
    quantity = params.fetch(:quantity, 1).to_i  # prendre la quantité fournie, sinon par défaut à 1
    result = current_user.cart.add_book_in_cart(book, quantity) #la methode add_book_in_cart se trouve dans le model JointTableCartBook

    if result.is_a?(CartBook) 
      redirect_to books_path, notice: "Le livre a été ajouté au panier avec succès" #dans le cas ou l'ajout se fait depuis de show_book
    else
      redirect_to books_path, notice: "Erreur" #dans le cas ou l'ajout se fait depuis de show_book
    end

  end

  def update
    cart_book = CartBook.find(params[:id])
    new_quantity = params.fetch(:quantity, 1).to_i

    if cart_book.update(quantity: new_quantity) #dans les cas ou les quantités peuvent seulement être modifiées depuis le panier
      redirect_to cart_path, notice: "La quantité a été mise à jour avec succès"
    else
      redirect_to cart_path, alert: "Erreur lors de la mise à jour de la quantité"
    end
  end

  def destroy
    cart_book = CartBook.find(params[:id])
    cart_book.destroy
    redirect_back(fallback_location: cart_path, notice: "Le livre a été supprimé du panier avec succès") #dans le cas ou la suppression se fait depuis de cart du user
  end
end

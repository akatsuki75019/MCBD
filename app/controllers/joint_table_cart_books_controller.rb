class JointTableCartBooksController < ApplicationController

  def index
    @cart_books = current_user.cart.cart_books
  end

  def create
    book = Book.find(params.fetch(:book_id, nil))
    quantity = params.fetch(:quantity, 1).to_i

    # Récupérer ou créer le panier de l'utilisateur actuel
    user_cart = if user_signed_in?
      current_user.cart || current_user.create_cart
    else
      Cart.find_or_create_by(id: session[:cart_id])
    end

    # Assurer que le panier est associé à l'utilisateur connecté (si disponible)
    user_cart.update(user: current_user) if user_signed_in?

    result = user_cart.add_book_in_cart(book, quantity)


    case result
    when JointTableCartBook
      redirect_to books_path, notice: "Le livre a été ajouté au panier avec succès"
    when "Quantité mise à jour dans le panier"
      redirect_to books_path, notice: "La quantité a été mise à jour dans le panier"
    when "La quantité demandée n'est pas disponible"
      redirect_to books_path, notice: "La quantité demandée n'est pas disponible"
    when "Le livre est en rupture de stock"
      redirect_to books_path, notice: "Le livre est actuellement en rupture de stock"
    else
      redirect_to books_path, notice: "Erreur lors de l'ajout au panier"
    end
  end



  def update
    @joint_table_cart_book = JointTableCartBook.find(params[:id])
    new_quantity = params.fetch(:quantity, 1).to_i

    if @joint_table_cart_book.update(quantity: new_quantity) #dans les cas ou les quantités peuvent seulement être modifiées depuis le panier
      redirect_to cart_path, notice: "La quantité a été mise à jour avec succès"
    else
      redirect_to cart_path, alert: "Erreur lors de la mise à jour de la quantité"
    end
  end

  def destroy
    joint_table_cart_book = JointTableCartBook.find(params[:id])
    joint_table_cart_book.destroy
    redirect_back(fallback_location: cart_path, notice: "Le livre a été supprimé du panier avec succès")
  end

end

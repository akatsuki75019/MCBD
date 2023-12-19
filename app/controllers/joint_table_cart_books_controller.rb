class JointTableCartBooksController < ApplicationController
  before_action :set_cart_book, only: %i[update destroy]

  def index
    @cart_books = current_user.cart.cart_books
  end

  def create
    book = Book.find(params.fetch(:book_id, nil))
    quantity = params.fetch(:quantity, 1).to_i

   
    if current_user
      user_cart = current_user.cart 
    else
      user_cart = Cart.find_or_create_by(id: session[:cart_id])
      session[:cart_id] ||= user_cart.id
    end

    result = user_cart.add_book_in_cart(book, quantity)
    case result
    when "Livre ajouté au panier"
      message = "Le livre a été ajouté au panier avec succès"
    when "Quantité mise à jour dans le panier"
      message = "La quantité a été mise à jour dans le panier"
    when "La quantité demandée n'est pas disponible"
      message = "La quantité demandée n'est pas disponible"
    when "Le livre est en rupture de stock"
      message = "Le livre est actuellement en rupture de stock"
    else
      message = "Erreur lors de l'ajout au panier"
    end
    redirect_to book_path(book), notice: message
  end

  def update
    @cart_book.update(quantity: cart_book_params[:quantity])
  end

  def destroy
    @cart_book.destroy
    redirect_back(fallback_location: cart_path, notice: "Le livre a été supprimé du panier avec succès")
  end

  private

  def set_cart_book
    @cart_book = JointTableCartBook.find(params[:id])
    @cart = @cart_book.cart
  end


  def cart_book_params
    params.require(:joint_table_cart_book).permit(:book_id, :cart_id, :quantity)
  end
end

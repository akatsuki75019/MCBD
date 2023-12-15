class CartsController < ApplicationController
  def show
    if user_signed_in?
      @cart = current_user.cart
      unless @cart
        # Si l'utilisateur est connecté mais n'a pas de panier, vous pouvez créer un panier pour lui.
        @cart = current_user.create_cart
      end

      # Vérifier si current user == cart user (pour empêcher l'affichage d'un autre panier)
      unless current_user == @cart.user
        redirect_to root_path, alert: "Vous n'avez pas les droits pour accéder à cette page."
        return
      end
    else
      @cart = Cart.find_by(id: params[:id])

      unless @cart
        redirect_to root_path, alert: "Panier non trouvé."
        return
      end
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

  def update
    @joint_table_cart_book.update(joint_table_cart_book_params)
  
    respond_to do |format|
      format.html { redirect_to @cart, notice: "Quantité mise à jour dans le panier" }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(@joint_table_cart_book) }
    end
  end

  def update_cart
    book_quantities_params.each do |book_id, book_quantity_params|
      book = Book.find(book_id)
      cart_book = current_user.cart.find_by(book: book)
      if cart_book && book-quantity_params[:quantity].to_i > 0
        cart_book.update(quantity: book_quantity_params[:quantity]
      elsif cart_book
        cart_book.destroy
      end
    end
    
    total_price = current_user.cart.total_price
    # Renvoyer le prix total en format JSON
    render json: { total_price: total_price }
  end

  private

  def book_quantities_params
    params.require(:book_quantities).permit!
  end


end

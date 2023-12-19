class CartTransferService
  def transfer_items(user, session_cart_id, session)
    user_cart = user.cart || user.create_cart

    guest_cart = Cart.find_by(id: session_cart_id)

    if guest_cart
      guest_cart.joint_table_cart_books.each do |cart_book|
        
        user_cart = user.cart || user.create_cart

        user_cart.add_book_in_cart(cart_book.book, cart_book.quantity)
        cart_book.destroy
      end

      session[:shopping_cart] = nil
    end
  end
end

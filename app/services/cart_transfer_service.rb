class CartTransferService

#methode de transfert des articles du guest cart vert le cart du user connecté et suppréssion des entrée cart_book rattaché au guest cart
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
    else
      puts "DEBUG: Guest Cart not found"
    end
  end
end
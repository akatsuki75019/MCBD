class JointTableCartBook < ApplicationRecord
  belongs_to :cart
  belongs_to :book


  #Ajouter une entrée "cart-book" dans la BDD
  def add_book_in_cart(book, quantity)
    cart_book = cart_books.find_by(book: book)
    # Vérifie si une entre Cart-Book existe dejà pour l'article spécifié dans le panier.

    if cart_book # Si le livre existe déjà dans le panier, mettre à jour la quantité en vérifiant si elle est nil.
      new_quantity = cart_book.quantity.to_i + quantity.to_i
      cart_book.update(quantity: new_quantity)
      return "Quantité mise à jour dans le panier"
    else # Sinon, créez un nouvel enregistrement CartBook pour ce livre dans le panier avec la quantité spécifiée.
      cart_book = cart_books.create(book: book, quantity: quantity)
      return cart_book
    end
  end


end

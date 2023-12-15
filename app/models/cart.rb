class Cart < ApplicationRecord
  has_many :joint_table_cart_books, dependent: :destroy
  has_many :books, through: :joint_table_cart_books
  belongs_to :user, optional: true

  # Règles de métiers pour ajouter une entrée "cart-book" dans la BDD
  def add_book_in_cart(book, quantity)
    user_cart = user&.cart || self # Si l'utilisateur est connecté, utilise son panier, sinon utilise le panier actuel
  
    return "La quantité demandée n'est pas disponible" if quantity > book.quantity
    return "Le livre est en rupture de stock" if book.quantity.zero?
  
    cart_book = user_cart.joint_table_cart_books.find_by(book: book)
  
    if cart_book
      new_quantity = cart_book.quantity.to_i + quantity.to_i
  
      if new_quantity > book.quantity
        return "La quantité demandée n'est pas disponible"
      else
        cart_book.update(quantity: new_quantity)
        return "Quantité mise à jour dans le panier"
      end
    else
      cart_book = joint_table_cart_books.create(book: book, quantity: quantity)
      if cart_book.persisted?
        return "Livre ajouté au panier"
      else
      end
    end
  end


  #parcourt les articles du panier temporaire, les ajoute au panier de l'utilisateur connecté s'ils sont en stock, et les supprime du panier temporaire. 
  #Si un article n'est plus en stock dans le panier de l'utilisateur connecté =message d'alerte 
  def total_price
    joint_table_cart_books.sum { |joint_table_cart_book| joint_table_cart_book.quantity * joint_table_cart_book.book.price_code.price }
  end

  #pour l'affichage du compteur dans la navbar
  def number_of_books_in_cart
    joint_table_cart_books.sum(:quantity)
  end

  
end

  
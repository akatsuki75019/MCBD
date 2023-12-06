class Cart < ApplicationRecord
  has_many :joint_table_cart_books
  has_many :books, through: :joint_table_cart_books
  belongs_to :user

  # Règles de métiers pour ajouter une entrée "cart-book" dans la BDD
  def add_book_in_cart(book, quantity)
    return "La quantité demandée n'est pas disponible" if quantity > book.quantity
    return "Le livre est en rupture de stock" if book.quantity.zero?

  # Association entre Cart et JointTableCartBook
    cart_book = joint_table_cart_books.find_by(book: book)

    if cart_book
      new_quantity = cart_book.quantity.to_i + quantity.to_i
      return "La quantité demandée n'est pas disponible" if new_quantity > book.quantity

      cart_book.update(quantity: new_quantity)
      return "Quantité mise à jour dans le panier"
    else
      cart_book = joint_table_cart_books.create(book: book, quantity: quantity)
      return cart_book
    end
  end

  def total_price
    joint_table_cart_books.sum { |joint_table_cart_book| joint_table_cart_book.quantity * joint_table_cart_book.book.price }
  end

end

  
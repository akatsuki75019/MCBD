class Order < ApplicationRecord
  belongs_to :user
  has_many :joint_table_order_books
  has_many :books, through: :joint_table_order_books


  def self.create_order_with_books(user, joint_table_cart_book_ids)
    order = create(user: user) # Crée une nouvelle instance de Order avec l'utilisateur spécifié
    total_price = 0

    joint_table_cart_book_ids.each do |joint_table_cart_book_id|
      joint_table_cart_book = JointTableCartBook.find(joint_table_cart_book_id)
      quantity = joint_table_cart_book.quantity

      order.joint_table_order_books.create(book: joint_table_cart_book.book, quantity: quantity) #Cela associe le livre à la commande et crée une nouvelle entrée dans la table de jointure 

      total_price += joint_table_cart_book.book.price_code.price * quantity # Ajoute le prix total de l'article au montant total de la commande


    end
    order.update(total_price: total_price) # Mise à jour du montant total de la commande
    order
  end 

  def self.create_order_for_express_purchase(current_user, book, total_price)
    order = create(user: current_user) # Crée une nouvelle instance de Order avec le current user
    order.books << book #ajoute les book dans l'instance
    order.total_price = total_price #définition du total price
    order.save
    order
  
  end
end

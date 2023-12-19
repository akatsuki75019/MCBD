class Order < ApplicationRecord
  belongs_to :user
  has_many :joint_table_order_books, dependent: :destroy
  has_many :books, through: :joint_table_order_books
  before_save :calculate_total_price
  after_save :send_confirmation_emails


  def self.create_order_with_books(user, joint_table_cart_book_ids)
    order = create(user: user) 
    total_price = 0

    joint_table_cart_book_ids.each do |joint_table_cart_book_id|
      joint_table_cart_book = JointTableCartBook.find(joint_table_cart_book_id)
      quantity = joint_table_cart_book.quantity

      order.joint_table_order_books.create(book: joint_table_cart_book.book, quantity: quantity) 
      total_price += joint_table_cart_book.book.price_code.price * quantity 
    end

    order.update(total_price: total_price) 
    order
  end 

  def self.create_order_for_express_purchase(current_user, book, total_price)
    order = create(user: current_user) 
    order.joint_table_order_books.create(book: book, quantity: 1) 
    order.total_price = total_price 
    order.save
    order
  end

  private

  def calculate_total_price
    self.total_price = joint_table_order_books.sum { |jtocb| jtocb.book.price_code.price * jtocb.quantity }
  end

  def send_confirmation_emails
    order_confirmation
    admin_order_confirmation
  end

  def order_confirmation
      UserMailer.order_confirmation(self).deliver_now
  end

  def admin_order_confirmation
    admin_users = User.where(is_admin: true)
    total_price = self.total_price

    admin_users.each do |admin_user|
      name_to_display = admin_user&.first_name.present? ? admin_user.first_name : 'Admin'
      AdminMailer.admin_order_confirmation(self, admin_user, name_to_display, total_price).deliver_now
    end
  end

end

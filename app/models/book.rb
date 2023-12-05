class Book < ApplicationRecord
  has_many :joint_table_cart_books, dependent: :destroy
  has_many :carts, through: :joint_table_cart_books

  has_many :joint_table_order_books, dependent: :nullify
  has_many :orders, through: :joint_table_order_books

  has_many :wishlists, dependent: :destroy

  belongs_to :editor
  belongs_to :category
  belongs_to :price_code
end

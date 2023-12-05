class Book < ApplicationRecord
  has_many :joint_table_cart_books, dependent: :destroy
  has_many :carts, through: :joint_table_cart_books

  has_many :joint_table_order_books, dependent: :nullify
  has_many :orders, through: :joint_table_order_books

  has_many :joint_table_wishlist_books, dependent: :destroy
  has_many :wishlists, through: :joint_table_wishlist_books
end

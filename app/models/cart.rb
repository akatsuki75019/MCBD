class Cart < ApplicationRecord
  has_many :joint_table_cart_books,
  has_many :books, through: :joint_table_cart_books
  belongs_to :user
end
class Wishlist < ApplicationRecord
  belongs_to :user
  has_many :joint_table_wishlist_books
  has_many :books, through: :joint_table_wishlist_books
end

class Book < ApplicationRecord
  has_many :joint_table_cart_books, dependent: :destroy
  has_many :carts, through: :joint_table_cart_books

  has_many :joint_table_order_books, dependent: :nullify
  has_many :orders, through: :joint_table_order_books

  has_many :wishlists, dependent: :destroy

  belongs_to :editor
  belongs_to :category
  belongs_to :price_code

  validates_presence_of :title, :author, message: "Il manque une ou plusieurs données"
  validates :isbn, presence: true, length: {in: 13..14, message: "L'ISBN doit comprendre 13 chiffres et 1 tiret."}

  #In Administrate views to show only price code name and not only id
  def price_code_name
    price_code.name if price_code
  end
end

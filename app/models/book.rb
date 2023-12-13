class Book < ApplicationRecord
  before_create :set_default_tva

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

  #gérer la màj des Qté lors de l'achat express
  def update_stock_quantity(quantity_to_reduce)
    new_stock_quantity = self.quantity - quantity_to_reduce
    update(quantity: new_stock_quantity)
  end

  #In Administrate views to show only price code name and not only id
  def find_category_name(category_id)
    category = Category.find_by(id: category_id)
    return category.name if category
  end

  # Pour obtenir la date formatée sans l'heure
  def formatted_release_date
    release_date.to_date
  end

  def set_default_tva
    self.tva ||= 5.5
  end
end

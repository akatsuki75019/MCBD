class Order < ApplicationRecord
  belongs_to :user
  has_many :joint_table_order_books
  has_many :books, through: :joint_table_order_books
end

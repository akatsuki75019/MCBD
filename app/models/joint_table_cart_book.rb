class JointTableCartBook < ApplicationRecord
  belongs_to :cart
  belongs_to :book
  validates :quantity, numericality: { greater_than_or_equal_to: 1 }
 
end

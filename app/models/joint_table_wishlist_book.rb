class JointTableWishlistBook < ApplicationRecord
  belongs_to :wishlist
  belongs_to :book
end

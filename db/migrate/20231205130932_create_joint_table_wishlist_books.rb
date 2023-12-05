class CreateJointTableWishlistBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :joint_table_wishlist_books do |t|

      t.timestamps
    end
  end
end

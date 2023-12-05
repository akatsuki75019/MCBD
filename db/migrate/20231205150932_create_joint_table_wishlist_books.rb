class CreateJointTableWishlistBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :joint_table_wishlist_books do |t|

      t.references :book, null: false, foreign_key: true
      t.references :wishlist, null: false, foreign_key: true

      t.timestamps
    end
  end
end

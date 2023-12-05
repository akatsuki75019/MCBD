class CreateJointTableCartBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :joint_table_cart_books do |t|
      t.integer :quantity
      
      t.references :cart, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end

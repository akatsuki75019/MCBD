class CreateJointTableOrderBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :joint_table_order_books do |t|
      t.integer :quantity

      t.references :order, null: false, foreign_key: true
      t.references :book, null: false, foreign_key: true

      t.timestamps
    end
  end
end

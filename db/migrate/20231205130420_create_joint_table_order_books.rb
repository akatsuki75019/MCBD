class CreateJointTableOrderBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :joint_table_order_books do |t|
      t.integer :quantity

      t.timestamps
    end
  end
end

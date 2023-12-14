class ChangeUserNullableInCarts < ActiveRecord::Migration[7.1]
  def change
    change_column :carts, :user_id, :bigint, null: true
  end
end

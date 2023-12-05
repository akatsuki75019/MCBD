class CreateWishlists < ActiveRecord::Migration[7.1]
  def change
    create_table :wishlists do |t|

      t.timestamps
    end
  end
end

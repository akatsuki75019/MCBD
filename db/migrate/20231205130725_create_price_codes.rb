class CreatePriceCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :price_codes do |t|
      t.string :name
      t.float :price

      t.timestamps
    end
  end
end

class CreatePriceCodes < ActiveRecord::Migration[7.1]
  def change
    create_table :price_codes do |t|
      t.string :price_code_name
      t.float :price

      t.timestamps
    end
  end
end

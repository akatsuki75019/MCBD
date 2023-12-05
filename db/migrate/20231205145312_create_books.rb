class CreateBooks < ActiveRecord::Migration[7.1]
  def change
    create_table :books do |t|
      t.string :isbn
      t.string :title
      t.string :author
      t.text :description
      t.integer :quantity
      t.datetime :release_date
      t.float :tva
      t.string :image_url

      t.references :editor, foreign_key: true
      t.references :price_code, foreign_key: true
      t.references :category, foreign_key: true

      t.timestamps
    end
  end
end

class CreateGoogleBookInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :google_book_infos do |t|
      t.references :book, null: false, foreign_key: true
      t.string :google_id
      t.text :google_description

      t.timestamps
    end
  end
end

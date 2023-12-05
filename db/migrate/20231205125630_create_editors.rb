class CreateEditors < ActiveRecord::Migration[7.1]
  def change
    create_table :editors do |t|
      t.string :name
      t.string :distributor

      t.timestamps
    end
  end
end

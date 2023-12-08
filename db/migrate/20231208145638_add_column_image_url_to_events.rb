class AddColumnImageUrlToEvents < ActiveRecord::Migration[7.1]
  def change
    add_column :events, :image_url, :string
  end
end

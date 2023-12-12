class ChangeReleaseDateTypeInBooks < ActiveRecord::Migration[7.1]
  def change
    change_column :books, :release_date, :date
  end
end

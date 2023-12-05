json.extract! book, :id, :isbn, :title, :author, :description, :quantity, :release_date, :tva, :image_url, :created_at, :updated_at
json.url book_url(book, format: :json)

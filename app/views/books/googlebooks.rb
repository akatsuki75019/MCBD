books = Book.all 

books.each do |book|
  next unless book.google_book_infos.blank?

  google_book = GoogleBooks.search("isbn:#{book.isbn}").first

  if google_book
    google_book_info = GoogleBookInfo.new(
      book: book,
      google_id: google_book.id,
      google_title: google_book.title,
      google_authors: google_book.authors.join(', '),
      google_published_date: google_book.published_date_french,
      google_isbn: google_book.isbn,
      google_description: google_book.description,
      google_image_link: google_book.image_link
    )
    google_book_info.save

  end
end
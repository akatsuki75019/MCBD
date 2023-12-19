module ApplicationHelper
  def book_jsonld(book)
    {
      "@context": "http://schema.org",
      "@type": "Book",
      "name": book.title,
      "author": {
        "@type": "Person",
        "name": book.author
      },
      # Ajout d'autres propriétés ici selon les besoins
    }.to_json.html_safe
  end
end

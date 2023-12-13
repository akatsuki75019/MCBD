require 'csv'

# Changez le chemin du fichier CSV selon son emplacement
csv_file_path = 'chemin/vers/votre_fichier.csv'

CSV.foreach(csv_file_path, headers: true) do |row|
  isbn = row['ISBN']
  quantity = row['Quantité']

  # Vérifiez si le livre existe déjà dans la base de données avant de l'insérer
  book = Book.find_or_initialize_by(isbn: isbn)
  book.quantity = quantity
  book.save
end

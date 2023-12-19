require 'net/http'
require 'uri'
require 'pg_search'
class Book < ApplicationRecord

  include PgSearch::Model
  pg_search_scope :search_book, against: [:title, :author, :description]

  includes :BooksHelper

  before_create :set_default_tva


  has_many :joint_table_cart_books, dependent: :destroy
  has_many :carts, through: :joint_table_cart_books

  has_many :joint_table_order_books, dependent: :nullify
  has_many :orders, through: :joint_table_order_books

  has_many :wishlists, dependent: :destroy

  belongs_to :editor, optional: true
  belongs_to :category, optional: true
  belongs_to :price_code, optional: true
  has_one :google_book_info

  validates :isbn, presence: true, length: {in: 10..14, message: "L'ISBN doit comprendre entre 10 et 13 chiffres, plus ou moins 1 tiret."}
  before_validation :scrap_google , on: :create

  #gérer la màj des Qté lors de l'achat express
  def update_stock_quantity(quantity_to_reduce)
    new_stock_quantity = self.quantity - quantity_to_reduce
    update(quantity: new_stock_quantity)
  end

  #In Administrate views to show only price code name and not only id
  def find_category_name(category_id)
    category = Category.find_by(id: category_id)
    return category.name if category
  end

  # Pour obtenir la date formatée sans l'heure
  def formatted_release_date
    release_date.to_date
  end

  def set_default_tva
    self.tva ||= 5.5
  end

  private 
  def scrap_json(url)
    
    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = (url.scheme == "https")
    req = Net::HTTP::Get.new(url)
    begin
      res = http.request(req)
    rescue StandardError => e
      puts "Une erreur s'est produite: #{e.message}"
    end
   
    return JSON.parse(res.body)
  end

  def scrap_google
        # Recupere les infos de google books via l'isbn du livre
    google_book = GoogleBooks.search("isbn:#{isbn}").first
    if google_book
      url = URI.parse(google_book.instance_variable_get("@item")["selfLink"])
      json = scrap_json(url)
      p json
      # Crée l'editeur si il n'est pas en BDD sinon lui attribut un existant
      editor =  Editor.find_or_create_by(name: json["volumeInfo"]["publisher"]) 

        
        self.title = json["volumeInfo"]["title"]|| "empty title"
        self.author = json["volumeInfo"]["authors"]&.join || "anonymous"
        self.release_date = json["volumeInfo"]["publishedDate"]|| "on sait pas"
        self.description = json["volumeInfo"]["description"]|| "description"
        self.editor = editor|| "anonymous"
        # Prio a la cover la plus grande
        self.image_url = json.dig("volumeInfo", "imageLinks", "thumbnail")

        # sinon les autres
        self.image_url ||= json.dig("volumeInfo", "imageLinks", "large")
        self.image_url ||= json.dig("volumeInfo", "imageLinks", "medium")
        self.image_url ||= json.dig("volumeInfo", "imageLinks", "small")

        # sinon une image qui dis "pas d'image dispo"
        self.image_url ||= "https://www.legrand.be/modules/custom/legrand_ecat/assets/img/no-image.png"

        

    end
  
  
  end
end

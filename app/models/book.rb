require 'net/http'
require 'uri'
class Book < ApplicationRecord

  includes :BooksHelper

  before_create :set_default_tva


  has_many :joint_table_cart_books, dependent: :destroy
  has_many :carts, through: :joint_table_cart_books

  has_many :joint_table_order_books, dependent: :nullify
  has_many :orders, through: :joint_table_order_books

  has_many :wishlists, dependent: :destroy

  belongs_to :editor
  belongs_to :category
  belongs_to :price_code
  has_one :google_book_info

  validates_presence_of :title, :author, message: "Il manque une ou plusieurs données"
  validates :isbn, presence: true, length: {in: 13..14, message: "L'ISBN doit comprendre 13 chiffres et 1 tiret."}
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

    google_book = GoogleBooks.search("isbn:#{isbn}").first
    if google_book
      url = URI.parse(google_book.instance_variable_get("@item")["selfLink"])
      json = scrap_json(url)
      p json
      editor =  Editor.find_or_create_by(name: json["volumeInfo"]["publisher"]) 

        
        self.title = json["volumeInfo"]["title"]|| "empty title"
        self.author = json["volumeInfo"]["authors"]&.join || "anonymous"
        self.release_date = json["volumeInfo"]["publishedDate"]|| "on sait pas"
        self.description = json["volumeInfo"]["description"]|| "description"
        self.image_url = json.dig("volumeInfo", "imageLinks", "large")|| "https://www.legrand.be/modules/custom/legrand_ecat/assets/img/no-image.png"
        self.editor = editor|| "anonymous"
        

    end
  
  
  end
end

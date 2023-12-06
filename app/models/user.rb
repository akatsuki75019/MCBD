class User < ApplicationRecord

  has_one :cart
  has_one :wishlist
  has_many :orders
  has_many :attendances
  has_many :events, through: :attendances

  after_create :create_user_cart

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable


  private

  def create_user_cart
    Cart.create(user: self)
  end
  
  validates :password, 
    presence: true, 
    length: { minimum: 6, message: "Votre mot de passe doit contenir à minima 6 caractères (chiffres et/ou lettres)" }
  
  validates :email, 
    presence: { message: "N'oubliez pas l'email 🤓" },
    uniqueness: { message: "Un compte possède déjà cet email, veuillez vous connecter" },
    format: { 
      #mon email ne peut contenir que des lettres non accentuées, des chiffres et/ou "_" + @ + idem + "." + 3 lettres 
      with: /\A[\p{L}0-9.!~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,4})\z/, message: "L'email renseigné est incorrect"
    } 
end

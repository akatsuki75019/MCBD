class User < ApplicationRecord

  has_one :cart
  has_one :wishlist
  has_many :orders
  has_many :attendances
  has_many :events, through: :attendances

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  validates :password, presence: true, length: { minimum: 6, message: "Votre mot de passe doit contenir à minima 6 caractères (chiffres et/ou lettres)" }
  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Attention : Email incorrect" } 
end

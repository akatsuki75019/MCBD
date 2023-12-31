class User < ApplicationRecord
  has_one :cart, dependent: :destroy
  has_one :wishlist, dependent: :destroy
  has_many :orders, dependent: :destroy
  has_many :attendances, dependent: :destroy
  has_many :events, through: :attendances

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable


  validates :password, 
    presence: true,
    length: { minimum: 6 },
    on: :create
  
  validates :email, 
    presence: { message: "N'oubliez pas l'email 🤓" },
    format: { 
      #mon email ne peut contenir que des lettres non accentuées, des chiffres et/ou "_" + @ + idem + "." + 3 lettres 
      with: /\A[\p{L}0-9.!~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z]{2,4})\z/, message: "L'email renseigné est incorrect"
    },
    on: :create

  
  after_create do
    create_user_cart 
    welcome_send
  end


  def welcome_send
    UserMailer.welcome_email(self).deliver_now
  end

  private

  def create_user_cart
    Cart.create(user: self)
  end
end

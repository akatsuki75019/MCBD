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
  
end

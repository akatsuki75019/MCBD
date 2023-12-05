class User < ApplicationRecord

  belongs_to :cart
  belongs_to :wishlist
  has_many :orders
  has_many :attendances
  

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
end

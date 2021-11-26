class Customer < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :orders, dependent: :destroy
  has_many :deliveries, dependent: :destroy
  has_many :cart_items, dependent: :destroy
  
  validates :is_deleted,inclusion:{in: [true, false]}
  
  validates :last_name, presence: true
  validates :first_name , presence: true
  validates :first_name_kana , presence: true
  validates :first_name_kana , presence: true
  validates :postal_code  , presence: true
  validates :address   , presence: true
  validates :tel   , presence: true
  
  
  
  
  
  
end

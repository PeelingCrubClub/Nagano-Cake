class Item < ApplicationRecord

  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  attachment :image

end

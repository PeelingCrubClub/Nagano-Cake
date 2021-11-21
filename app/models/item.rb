class Item < ApplicationRecord

  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genre
  attachment :image

validates :item_status, presence:{in: [true, false]}
end
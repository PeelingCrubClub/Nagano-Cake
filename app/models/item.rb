class Item < ApplicationRecord

  has_many :carts, dependent: :destroy
  has_many :order_items, dependent: :destroy
  belongs_to :genres
  attachment :image

  # 商品価格に消費税を加える記述
  def add_tax_price
    (self.price * 1.10).round
  end
end

class CartItem < ApplicationRecord

  belongs_to :customer
  belongs_to :item

  def sum_of_price
    item.add_tax_price * pieces
  end

  scope :items_of_price, -> { inject(0){ |sum, item| sum + item.sum_of_price } }

end

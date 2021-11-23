class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :customer

  enum order_status: { waiting_for_deposit: 0, confirmed_payment: 1, in_production: 2, ready_to_delivery: 3, done: 4 }
 
  enum status: { waiting_payment: 0, payment_confirm: 1, in_production: 2, ready_to_ship: 3, shipped: 4 }
  enum payment: { クレジットカード: 0, 銀行振込: 1 }

end

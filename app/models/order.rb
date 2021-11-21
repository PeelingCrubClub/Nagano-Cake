class Order < ApplicationRecord

  has_many :order_items, dependent: :destroy
  belongs_to :customer

  enum order_status: { waiting_for_deposit: 0, confirmed_payment: 1, in_production: 2, ready_to_delivery: 3, done: 4 }


end

class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item

  enum production_status: { unable: 0, waiting: 1, working: 2, completed: 3 }
  enum order_status: { waiting_for_deposit: 0, confirmed_payment: 1, in_production: 2, ready_to_delivery: 3, done: 4 }


end

class OrderItem < ApplicationRecord

  belongs_to :order
  belongs_to :item
  
  enum roduction_status: { unable: 0, witing: 1, working: 2, completed: 3 }

end

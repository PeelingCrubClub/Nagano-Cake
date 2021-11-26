class Delivery < ApplicationRecord

  belongs_to :customer

  def full_address
    "〒#{self.delivery_postal_code} #{self.delivery_address} #{self.address_name}"
  end
  

end

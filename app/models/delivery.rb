class Delivery < ApplicationRecord

  belongs_to :customer

  validates :address_name, presence: true
  validates :delivery_address, presence: true
  validates :delivery_postal_code, presence: true

  def full_address
    "〒#{self.delivery_postal_code} #{self.delivery_address} #{self.address_name}"
  end

end

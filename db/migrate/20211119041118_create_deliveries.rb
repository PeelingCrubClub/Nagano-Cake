class CreateDeliveries < ActiveRecord::Migration[5.2]
  def change
    create_table :deliveries do |t|
      t.integer :customer_id
      t.string :delivery_postal_code
      t.string :address_name
      t.string :delivery_address

      t.timestamps
    end
  end
end

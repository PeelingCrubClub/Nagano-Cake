class ChangeColumnDefaultToOrders < ActiveRecord::Migration[5.2]
  def change
    change_column_default :orders, :order_status, from: nil, to: "0"
  end
end

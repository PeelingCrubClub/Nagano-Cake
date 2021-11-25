class Admin::OrderItemsController < ApplicationController
#   before_action :authenticate_admin!

  def update
    order_item =OrderItem.find(params[:id])
    order = Order.find(params[:order_id])

        order_item.update(order_item_params)
        if
            order_item.order.order_items.all? { |order_item| order_item.production_status == "completed" }
            order.update(order_status: "ready_to_delivery")
        end
           redirect_to admin_order_path(order)
   end

  private
   def order_item_params
      params.require(:order_item).permit(:production_status)
   end

end

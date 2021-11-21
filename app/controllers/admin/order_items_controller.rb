class Admin::OrderItemsController < ApplicationController
  
  def update
    order_item =OrderItem.find(params[:id])
		order_detail.update(order_detail_params)
  end
  
  private
   def order_item_params
      params.require(:order_item).permit(:production_status) 
   end
  
end

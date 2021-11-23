class Admin::OrderItemsController < ApplicationController

  def update
    order_item =OrderItem.find(params[:id])
    order = Order.find(params[:order_id])
   if
	    order_item.update(order_item_params)
		   redirect_to admin_order_path(order), notice:"製作ステータスを更新しました"#非同期通信導入検討
   else
       render :show, alert: "ステータスを更新できませんでした"
   end
  end

  private
   def order_item_params
      params.require(:order_item).permit(:production_status)
   end

end

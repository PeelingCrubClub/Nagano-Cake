class Admin::OrderItemsController < ApplicationController
#   before_action :authenticate_admin!

  def update
    order_item =OrderItem.find(params[:id])
    order = Order.find(params[:order_id])

    # order = Order.find(params[:id])
    # order_items = order.order_items

    # if order.update(order_item_params)
    #   if order.order_status == 1
    #       order.order_item.update_all(status: 1)
    #       redirect_to request.referer, notice:"製作ステータスを更新しました"
    #   elsif order.status == 2
    #         ordered.order_item.update_all(status: 2)
    #         redirect_to request.referer, notice:"製作ステータスを更新しました"
    #   else
    #         redirect_to request.referer, alert: "ステータスを更新できませんでした"
    #   end
    # end
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

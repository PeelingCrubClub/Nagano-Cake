class Admin::OrdersController < ApplicationController

  def index
   @orders = Order.all.page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    order = Order.find(params[:id])
		order_items = order.order_item
  
    if order.update(order_params)
       redirect_to admin_order_path(order), notice:"注文ステータスを更新しました"#非同期通信導入検討
    else
       render :show, alert: "注文ステータスを更新できませんでした"
    end
  end


  private
	def order_params
		params.require(:order).permit(:order_status)
	end

end

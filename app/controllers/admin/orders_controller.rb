class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
    order = Order.find(params[:id])
		order_items = order.order_item
　  order.update(order_params)
  end


  private
	def order_params
		params.require(:order).permit(:order_status)
	end

end

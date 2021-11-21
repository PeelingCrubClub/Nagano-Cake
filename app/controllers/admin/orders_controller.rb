class Admin::OrdersController < ApplicationController

  def index
    @orders = Order.all(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end

  def update
  end

end

class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  
  def index
   @count = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
   @orders = Order.all.page(params[:page]).per(10)
   
  case params[:order]
    when 'today'
      @orders = Order.page(params[:page]).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).per(10) #ここまでできてる
    when 'customer'
      customer_id = Rails.application.routes.recognize_path(request.referer)[:id]
      @customer = Customer.find(customer_id)
      @orders = @customer.orders.page(params[:page]).per(10)

  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
    end
    
  end

  def update
    order = Order.find(params[:id])
		order_items = order.order_items
  
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

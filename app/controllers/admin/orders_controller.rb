class Admin::OrdersController < ApplicationController
      before_action :authenticate_admin!

  def index
   @count = Order.where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).count
   @orders = Order.all.page(params[:page]).per(10)

  case params[:order]
  when 'today' then
      @orders = Order.page(params[:page]).where(created_at: Time.zone.now.beginning_of_day..Time.zone.now.end_of_day).per(10) #ここまでできてる
  when 'customer' then
      customer_id = Rails.application.routes.recognize_path(request.referer)[:id]
      @customer = Customer.find(customer_id)
      @orders = @customer.orders.page(params[:page]).per(10)
  end
  end

  def show
    @order = Order.find(params[:id])
    @order_items = @order.order_items.all
  end


		def update
	    @order = Order.find(params[:id])
      order_items = @order.order_items

       @order.update(order_params)
        if @order.order_status =="confirmed_payment"    #1
          order_items.update(production_status: "waiting")#1)
        elsif @order.order_status == "in_production"#2
          order_items.update(production_status: "working")#2)

        end
         redirect_to admin_order_path(@order)

    end

  private
	def order_params
		params.require(:order).permit(:order_status)
	end

end

class Admin::OrdersController < ApplicationController
  # before_action :authenticate_admin!

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

		case @order.order_status
		 when "入金確認"
				@order.order_item.update_all(production_status: "製作待ち")
		 when "製作中"
			  @order.order_item.update_all(production_status: "製作中")
		 end
		 redirect_to admin_order_path(@order)
	end
	
    
    
    
    #1つ目
  #   @order = Order.find(params[:id])
		# order_items = @order.order_items
		# @order.update(order_params)
		  #   # if order.update(order_params)
  #   redirect_to admin_order_path(@order), notice:"注文ステータスを更新しました"#非同期通信導入検討
  #   # else
  #   #   #alert: "注文ステータスを更新できませんでした"
  #   # end
  # end

		#2つ目
		#   @order = Order.find(params[:id])
  #     order_items = @order.order_items

  #   if @order.update(order_params)
  #       if @order.order_status =="入金確認"    #1
  #         order.order_item.update_all(production_status: "製作待ち")#1)
  #         redirect_to request.referer, notice:"製作ステータスを更新しました"
  #       elsif @order.order_status == "製作中"#2
  #           ordered.order_item.update_all(production_status: "製作中")#2)
  #           redirect_to request.referer, notice:"製作ステータスを更新しました"
  #       else
  #           redirect_to request.referer, alert: "ステータスを更新できませんでした"
  #       end
  #   end
  # end




  private
	def order_params
		params.require(:order).permit(:order_status)
	end

end

class Public::OrdersController < ApplicationController

   def new
     @order = Order.new
     @deliveries = current_customer.deliveries
   end

   def create
     @order = Order.new(order_params)
     if @order.save
       @cart_items = current_customer.cart_items.all
       @cart_items.each do |cart_item|
         @order_items = @order.order_items.new
         @order_items.item_id = cart_item.items.id
         @order_items.tax_price = cart_item.item.tax_price * 1.1
         @order_items.number_of_piaces = cart_item.piaces
         @order_items.save
         current_customer.cart_items.destroy_all
       end
       redirect_to orders_complete_orders_path
     else
       @deliveries = current_customer.deliveries
       render :new, alert: "カートに商品が入っておりません"
     end
   end

   def index
     @orders = Order.where(customer_id: current_customer.id).page(params[:page]).per(5)
   end

   def show
     @order = Order.find(params[:id])
   end

   def confirm
     @order = Order.new(order_params)
     @order.customer_id = current_customer.id
     @order.shipping_fee = 800 #送料の設定
     @cart_items = current_customer.cart_items
     @all_price = @order.shipping_fee + @cart_items.items_of_price #請求額の合計

     if params[:order][:to_address] == "0"
        @receiver_name = current_customer.last_name + current_customer.first_name
        @shipping_postal_code = current_customer.postal_code
        @delivery_address = current_customer.address
     elsif params[:order][:to_address] == "1" #お届けの方法が登録している住所の時
        @customer_address = Delivery.find(params[:order][:delivery_id])
        @receiver_name = @customer_address.name
        @shipping_postal_code = @customer_address.postal_code
        @delivery_address = @customer_address.address
     elsif  params[:order][:to_address] == "2" #新しいお届け先
        @receiver_name = @order.receiver_name
        @shipping_postal_code = @order.shipping_postal_code
        @delivery_address = @order.delivery_address
     end
   end

   def complete
   end

  private

  def order_params
  params.require(:order).permit(:customer_id, :shipping_fee, :total_price, :payment_method, :receiver_name, :shipping_postal_code, :delivery_address, :order_status)
  end

end

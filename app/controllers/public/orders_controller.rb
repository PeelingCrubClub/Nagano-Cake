class Public::OrdersController < ApplicationController

   def new
     @order = Order.new
     @cart_item = CartItem.where(customer_id: current_customer.id)
     @customer = current_customer
     @address_new = Delivery.new
   end

   def create
     @cart_items = current_customer.cart_items
     @order = current_customer.orders.new(order_params)
     if @order.save
       @cart_items.each do |cart_item|
         order_item = OrderItem.new
         order_item.item_id = cart_item.item_id
         order_item.order_id = @order.id
         order_item.tax_price = cart_item.item.price   #右辺上下逆
         order_item.number_of_piaces = cart_item.pieces
         order_item.save
       end
       redirect_to orders_complete_orders_path
       @cart_items.destroy_all
     else
       @order = Order.new(order_params)
       render :new
     end
   end

   def index
     @orders = current_customer.orders.page(params[:page]).reverse_order.per(10)
   end

   def show
     @order = Order.find(params[:id])
     @ordered_items = @order.order_items
     @order.shipping_fee = 800
   end

   def confirm
     @order = Order.new(order_params)
     @order.shipping_fee = 800 #送料の設定
     if params[:order][:to_address] == "0"
        @order.shipping_postal_code = current_customer.postal_code
        @order.delivery_address = current_customer.address
        @order.receiver_name = current_customer.last_name + current_customer.first_name
     elsif params[:order][:to_address] == "1" #お届けの方法が登録している住所の時
        @delivery = Delivery.find(params[:order][:delivery_id])
        @order.shipping_postal_code = @delivery.delivery_postal_code
        @order.delivery_address = @delivery.delivery_address
        @order.receiver_name = @delivery.address_name
     elsif  params[:order][:to_address] == "2" #新しいお届け先
        @address_new = current_customer.deliveries.new
        @address_new.customer_id = current_customer.id
        @address_new.delivery_postal_code = @order.shipping_postal_code
        @address_new.delivery_address = @order.delivery_address
        @address_new.address_name = @order.receiver_name
        if @address_new.save(order_params)
        end
     else
       redirect_to new_order_path
     end
    @cart_items = current_customer.cart_items.all
   end

   def complete
   end

  private

  def order_params
  params.require(:order).permit(:customer_id, :shipping_fee, :total_price, :payment_method, :receiver_name, :shipping_postal_code, :delivery_address, :order_status)
  end

end
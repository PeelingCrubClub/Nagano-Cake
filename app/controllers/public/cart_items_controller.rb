class Public::CartItemsController < ApplicationController

 def index
  @cart_items = CartItem.where(customer_id: current_customer.id)
  @customer = current_customer
 end

 def create
 end

 def update
 end
 
 def destroy
 end
 
 def destroy_all
 end
 

end

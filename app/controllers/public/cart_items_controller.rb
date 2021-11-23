class Public::CartItemsController < ApplicationController

 def index
  @cart_items = CartItem.where(customer_id: current_customer.id)
  @customer = current_customer
 end

 def create
  @cart_item = CartItem.new(cart_item_params)
  @cart_item.customer_id = current_customer.id
  cart_item = current_customer.cart_items.find_by(item_id: params[:cart_item][:item_id])
  if cart_item.present?
    cart_item.count += params[:cart_item][:count].to_i
    cart_item.save
    redirect_to cart_items_path
  else
    @cart_item.save!
    redirect_to cart_items_path
  end
 end

 def update
  @cart_item = CartItem.find(params[:id])
  @cart_item.update(cart_item_params)
  redirect_to request.referer
 end
 
 def destroy
  @cart_item = CartItem.find(params[:id])
  @cart_item.destroy
  redirect_to request.referer
 end
 
 def destroy_all
  current_customer.cart_items.destroy_all
  redirect_to request.referer
 end
 
 private

 def cart_item_params
   params.require(:cart_item).permit(:customer_id, :item_id, :count)
 end
 
end

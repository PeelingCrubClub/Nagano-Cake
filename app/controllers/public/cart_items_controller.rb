class Public::CartItemsController < ApplicationController

 def index
  @cart_items = CartItem.all
  @customer_cart_items = CartItem.where(customer_id: current_customer.id)
 end

 def create
  @cart_item = CartItem.new(cart_item_params)
  @item = @cart_item.item
    if @cart_item.save
      redirect_to cart_items_path, notice: "カートに商品が入りました"
    else
      redirect_to item_path(@item), notice: "商品の個数を指定してください"
    end
 end

 def update
  @cart_item = CartItem.find(params[:id])
  if @cart_item.update(cart_item_params)
    redirect_to request.referer, notice: "購入商品の個数を変更しました"
  end
 end

 def destroy
  @cart_item = CartItem.find(params[:id])
  if @cart_item.destroy
    redirect_to request.referer, notice: "商品を削除しました"
  end
 end

 def destroy_all
  if CartItem.destroy_all
    redirect_to request.referer, notice: "カート内を全て削除しました"
  end
 end

 private

 def cart_item_params
   params.require(:cart_item).permit(:customer_id, :item_id, :pieces)
 end

end

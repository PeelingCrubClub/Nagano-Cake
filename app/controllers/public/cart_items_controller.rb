class Public::CartItemsController < ApplicationController
  before_action :move_to_signed_in 

 def index
  @cart_items = CartItem.all
  @customer_cart_items = CartItem.where(customer_id: current_customer.id)
 end

 def create
  @cart_item = CartItem.new(cart_item_params)
  @item = @cart_item.item
    if @cart_item.save
      redirect_to cart_items_path,notice: "カートに商品が入りました"
    else
      redirect_to item_path(@item), notice: "商品の個数を指定してください"
    end
 end

 def update
  @cart_item = CartItem.find(params[:id])
  if @cart_item.update(cart_item_params)
    flash[:notice] = "商品の個数を変更しました"
    redirect_to request.referer
  else
    flash[:alert] = "商品個数の変更に失敗しました"
  end
 end

 def destroy
  @cart_item = CartItem.find(params[:id])
  if @cart_item.destroy
    redirect_to request.referer, alert: "商品を削除しました"
  end
 end

 def destroy_all
  if CartItem.destroy_all
    redirect_to request.referer, alert: "カート内を全て削除しました"
  end
 end

  def move_to_signed_in
    unless customer_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/customers/sign_in'
    end
  end

 private

 def cart_item_params
   params.require(:cart_item).permit(:customer_id, :item_id, :pieces)
 end

end

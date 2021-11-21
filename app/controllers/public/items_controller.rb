class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @customer = current_customer
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem.new
    @customer = current_customer
    @genres = Genre.all
  end

end

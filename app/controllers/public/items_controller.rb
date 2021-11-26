class Public::ItemsController < ApplicationController

  def index
    @items = Item.all.page(params[:page]).per(9)
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

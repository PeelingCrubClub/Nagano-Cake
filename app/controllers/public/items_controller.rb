class Public::ItemsController < ApplicationController
  before_action :move_to_signed_in, except: [:index]
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

  def move_to_signed_in
    unless customer_signed_in?
      #サインインしていないユーザーはログインページが表示される
      redirect_to  '/customers/sign_in'
    end
  end

end
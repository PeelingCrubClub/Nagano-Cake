class Public::ItemsController < ApplicationController

  def index
    @items = Item.all
    @customer = current_customer
  end

  def show
  end

end

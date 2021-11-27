class Admin::ItemsController < ApplicationController

  def new
    @item = Item.new
  end

  def index
    @item = Item.all.page(params[:page]).per(10)
  end

  def search
    if params[:keyword].present?
       @items = Item.where('item_name LIKE ?', "%#{params[:keyword]}%")
    else
      @items = Item.none
    end
  end


  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:notice] = "商品を追加しました"
      redirect_to admin_item_path(@item.id)
    else
      render :new
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] = "商品情報を変更しました"
      redirect_to admin_item_path
    else
      render :edit
    end
  
    
  end

  private
  def item_params
    params.require(:item).permit(:image, :item_name,:detail,:price,:item_status,:genre_id,:validation)
  end
end
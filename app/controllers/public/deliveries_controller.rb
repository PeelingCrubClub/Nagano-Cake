class Public::DeliveriesController < ApplicationController

  def index

    @delivery_new = Delivery.new
    @deliveries = current_customer.deliveries.page(params[:page]).per(5)
    
    #@customer = Customer.find(params[:id])
    #@deliveries = current_customer.deliveries.page(params[:page]).reverse_order.per(5)
    
  end
   

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
      flash[:notice] = "配送先を登録しました"
       redirect_to deliveries_path
    else
       @delivery_new = Delivery.new
       @deliveries = current_customer.deliveries
       render :index
    end
  end

  def edit
    @delivery_new = Delivery.new
    @delivery = Delivery.find(params[:id])
  end

  def update
    delivery = Delivery.find(params[:id])
    if delivery.update(delivery_params)
      flash[:notice] = "配送先情報を変更しました"
    redirect_to deliveries_path
    else
      render :edit
    end
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    # redirect_to deliveries_path
    redirect_to action: 'index'
  end

  private
  def delivery_params
      params.require(:delivery).permit(:delivery_postal_code, :address_name, :delivery_address )
  end

end



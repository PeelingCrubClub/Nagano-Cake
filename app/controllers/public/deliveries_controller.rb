class Public::DeliveriesController < ApplicationController

  def index
    @delivery_new = Delivery.new. #なんのための_new?
    @deliveries = current_customer.deliveries.page(params[:page]).per(5)

    #@customer = Customer.find(params[:id])
    #@deliveries = current_customer.deliveries.page(params[:page]).reverse_order.per(5)

  def create
    @delivery = Delivery.new(delivery_params)
    @delivery.customer_id = current_customer.id
    if @delivery.save
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
    delivery.update(delivery_params)
    redirect_to deliveries_path
  end

  def destroy
    delivery = Delivery.find(params[:id])
    delivery.destroy
    redirect_to deliveries_path
  end

  private
  def delivery_params
      params.require(:delivery).permit(:last_name, :first_name, :delivery_postal_code, :address_name)
  end
end
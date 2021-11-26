class Admin::CustomersController < ApplicationController

  def index
    @customer = Customer.all
  end

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      flash[:notice] = "会員情報を変更しました"
      redirect_to admin_customer_path(@customer)
    else
      render :edit
  end
end

  private
  def customer_params
    params.require(:customer).permit(
      :first_name,:last_name,:first_name_kana,:last_name_kana,:postal_code,:address,:tel,:is_deleted)
    end
  end
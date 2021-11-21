class Public::CustomersController < ApplicationController
   
   before_action :ensure_correct_customer, {only: [:show, :edit]}
  
   def show
      @customer = Customer.find_by(params[:id])
   end
   
   def edit
   @customer = Customer.find(params[:id])
   end
   
   def update
      
    @customer = @customer.update(customer_params)
   if @customer.update(customer_params)
    redirect_to customer_edit_path(current_user.id), notice: "You have updated user successfully."
    
   else
   
   render 'edit'
    
   end
   
   end
   
   
   def leave
    @customer = Customer.find(params[:id])
   end
   
   def out
   @customer = Customer.find(params[:id])
       if @customer.update(is_enabled: false)
          sign_out current_customer #Uコントローラーから直接サインアウト（devise公式)
       end
       redirect_to root_path
   end
    
  private
  def customer_params
  	  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
  	                                   :tel, :email, :password, :postal_code, :address)
  end

  def ensure_correct_customer
    @customer = Customer.find(params[:id])
    if current_customer.id != @customer.id
       redirect_to root_path
    end
  end
end
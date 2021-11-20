class Public::CustomersController < ApplicationController
  
   def show
      @customer = Customers.find_by(params[:id])
   end
   
   def edit
      
   @customer = Customers.find_by(params[:id])  
   
   unless @customer == current_customer
   
   render customer_edit_path(@customer.id), user:@user 
   
   end
       
      
      
   end
   
   def update
      
    @customer = @customer.update(params_customer)
   if @customer.update(customer_params)
    redirect_to customer_edit_path(current_user.id), notice: "You have updated user successfully."
    
   else
   
   render 'edit'
    
   end
   
   end
   
   
   def leave
   end
   
   def out
   end
end

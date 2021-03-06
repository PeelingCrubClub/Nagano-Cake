class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def after_sign_in_path_for(resource)
    customer_path(current_customer.id)
  end


  def after_sign_out_path_for(resource)
    root_path # ログアウト後に遷移するpathを設定
  end

 def require_login!
 if session[:customer_email].nil?
 redirect_to login_path
 end
 end
 before_action :authenticate_customer!,except: [:top,:about]

 add_flash_types :success, :info, :warning, :danger


  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
      devise_parameter_sanitizer.permit(:sign_up,keys:[:email])
  end




end

class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters_for_login, if: :devise_controller?
  protected
  
  def configure_permitted_parameters_for_login
    devise_parameter_sanitizer.permit(:sign_in) do |user_params|
      user_params.permit(:login,:password,:remember_me)
    end
  end

  def after_sign_in_path_for(resource)
   if resource_name == :developer
     '/'
 	 else
 	 	admin_root_url
 	 end
  end
  
# =======
#     if resource_name == :developer	 	
#      '/'
#    elsif resource_name == :admin_user
#      admin_root_url
#    end
#  end  
# >>>>>>> 45ef2c678690c8e16bac0c9c7b31f57495eebf99
end

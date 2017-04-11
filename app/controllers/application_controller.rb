class ApplicationController < ActionController::Base

   rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, :alert => exception.message
  end

  def current_ability
    @current_ability ||= Ability.new(current_admin_user)
  end 
  
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
  
  def verrify_mac_address
        if current_developer.present? and (current_developer.sign_in_mac != Mac.addr)
          scope = Devise::Mapping.find_scope!(current_developer)
          redirect_path = after_sign_out_path_for(scope)
          Devise.sign_out_all_scopes ? sign_out : sign_out(scope)
          flash[:warning]= "Please login from your last login system."
          redirect_to redirect_path
        end
  end

end

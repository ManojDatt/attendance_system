class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters_for_login, if: :devise_controller?
  protected
  
  def configure_permitted_parameters_for_login
      devise_parameter_sanitizer.permit(:sign_in) do |user_params|
        user_params.permit(:login,:password,:remember_me)
      end
  end
  
end

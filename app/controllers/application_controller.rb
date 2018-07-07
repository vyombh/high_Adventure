class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception 
  before_filter :configure_permitted_parameters, if: :devise_controller?
   protected

   def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys:[:firstname, :lastname, :email, :password])
        devise_parameter_sanitizer.permit(:account_update,keys:[:firstname,:lastname, :email, :password])
   end

   def after_sign_in_path_for(resources)
   	    sign_in_url = new_user_session_url
   	    sign_up_url = new_user_registration_url
	   	if request.referer == sign_in_url || request.referer == new_user_registration_url
	   		room_papa_index_path
	   	else
	   		stored_location_for(resources)	|| request.referer || root_path
	   	end
   end
end

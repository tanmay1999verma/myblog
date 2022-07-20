class ApplicationController < ActionController::Base
   protect_from_forgery with: :exception

     before_action :configure_permitted_parameters, if: :devise_controller?

     protected

          def configure_permitted_parameters
               devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:first_name, :last_name, :phone_number, :email, :password, :password_confirmation)}

               # devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:name, :email, :password, :current_password)}
          end
   protected
         def after_sign_in_path_for(users)
                articles_path
         end
   def refresh
       redirect_back(fallback_location: root_path)
   end

end

class ApplicationController < ActionController::Base
        before_action :banned?
        before_action :configure_permited_parameters, if: :devise_controller?
            
        
        protected

        def banned?
                if current_user.present? && current_user.banned?
                        sign_out current_user
                        flash[:notice] = 'te baneamos'
                        redirect_to root_path
                end
        end
        

        def configure_permited_parameters
                devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :url_photo])
        end
        #se permiten lo parametro para ocuparlo en devise 
end

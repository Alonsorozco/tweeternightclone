class ApplicationController < ActionController::Base
    protect_from_forgery with: :exception
        
        before_action :configure_permited_parameters, if: :devise_controller?
            
        protected
        def configure_permited_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :url_photo])
        end
        #se permiten lo parametro para ocuparlo en devise 
end

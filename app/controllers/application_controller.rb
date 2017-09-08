class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

    def configure_permitted_parameters
      # sign_upのときに、nameをストロングパラメータに追加する
      devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :email])
      # account_updateのときに、nameをストロングパラメータに追加する
      devise_parameter_sanitizer.permit(:account_update, keys: [:name, :email, :introduction, :image, :locked])

    end

    def after_sign_in_path_for(resource)
      user_path(resource)
    end
    
  

end

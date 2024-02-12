class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # /users/sign_up
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :phone_number, :full_name])
    devise_parameter_sanitizer.permit(:account_update, keys: [:name, :profile])
  end

  def after_sign_up_path_for(resource)
    user_show_path(resource) # サインアップ後にユーザーのプロフィールページにリダイレクト
  end
end

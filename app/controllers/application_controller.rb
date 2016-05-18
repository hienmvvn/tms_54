class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_filter :configure_devise_permitted_parameters, if: :devise_controller?

  include UsersHelper

  rescue_from CanCan::AccessDenied do |exception|
    redirect_to root_url, alert: exception.message
  end
  
  protected
  def configure_devise_permitted_parameters
    devise_parameter_sanitizer.for(:account_update) do |user| 
      user.permit :name, :email, :password, :current_password 
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  before_action :configuration_permitted_parameters, if: :devise_controller?

  protected

  def configuration_permitted_parameters
    devise_parameter_sanitizer.for(:sign_up) { |u| u.permit({ roles: [] }, :username, :first_name, :last_name, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:sign_in) { |u| u.permit({ roles: [] }, :username, :email, :password, :remember_me) }
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit({ roles: [] }, :username, :first_name, :last_name, :email, :password, :current_password) }
  end
end

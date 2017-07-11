class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include Pundit

  before_action :configure_permitted_parameters, if: :devise_controller?
  alias current_user current_member
  rescue_from Pundit::NotAuthorizedError, with: :member_not_authorized

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:first_name, :last_name])
  end

  private

  def member_not_authorized
    flash[:alert] = 'You are not authorized to perform this action.'
    redirect_to(request.referrer || root_path)
  end
end

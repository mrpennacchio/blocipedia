class ApplicationController < ActionController::Base
  include Pundit

  after_action :verify_authorized, except: [:index, :show], unless: :devise_controller?

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  skip_before_action :verify_authenticity_token

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized


  # before_action :authenticate_user!

  protected

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referrer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

end

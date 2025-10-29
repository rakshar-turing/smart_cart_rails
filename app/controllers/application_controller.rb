class ApplicationController < ActionController::Base
  include Pundit::Authorization

  before_action :authenticate_user!
  
  after_action :verify_authorized, except: :index, unless: :skip_pundit?
  after_action :verify_policy_scoped, only: :index, unless: :skip_pundit?
  before_action :configure_permitted_parameters, if: :devise_controller?

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  rescue_from Pundit::NotDefinedError, with: :policy_not_defined

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_in, keys: [:email, :password])
  end

  private

  def skip_pundit?
    devise_controller? ||
      controller_path.start_with?('devise/') ||
      controller_path.start_with?('rails/')
  end

  def user_not_authorized
    flash[:alert] = "You are not authorized to perform this action."
    redirect_to(request.referer || root_path)
  end

  def policy_not_defined
    render json: { error: "Policy not defined" }, status: :forbidden
  end
end

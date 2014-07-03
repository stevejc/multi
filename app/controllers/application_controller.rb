class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :scope_current_account
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite).concat([:account_id])
  end

  private

  def current_account
  current_user.account if current_user
  end
  helper_method :current_account
  
  def scope_current_account
    Account.current_id = current_account.id if current_user
    yield
  ensure
    Account.current_id = nil
  end
  
  def after_invite_path_for(resource)
    users_path
  end
  

  
end




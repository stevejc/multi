class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :scope_current_account

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

  
end

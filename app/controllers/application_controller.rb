class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :scope_current_account
  before_filter :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite).concat([:account_id, :name])
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
  
  def after_sign_in_path_for(resource_or_scoped)
    users_path
  end

  private

  def current_account
    session[:account] = current_user.user_accounts.first.account_id if session[:account].nil?
    current_user.user_accounts.find_by_account_id(session[:account]).account
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
  
  def only_owners(page)             
    if current_account.owner_id != current_user.id
      flash[:alert] = "You must be the account owner to access the #{page} page."
      redirect_to root_path # halts request cycle
    end
  end
  

  
end




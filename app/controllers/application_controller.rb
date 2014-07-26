class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  around_filter :scope_current_account
  before_filter :configure_permitted_parameters, if: :devise_controller?
  after_filter :store_location

  protected
  def store_location
    # store last url - this is needed for post-login redirect to whatever the user last visited.
    return unless request.get? 
    if (request.path != "/users/sign_in" &&
        request.path != "/users/sign_up" &&
        request.path != "/users/password/new" &&
        request.path != "/users/sign_out" &&
        !request.xhr?) # don't store ajax calls
      session[:previous_url] = request.fullpath 
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.for(:invite).concat([:account_id, :name])
    devise_parameter_sanitizer.for(:account_update) { |u| u.permit(:name, :email, :password, :current_password) }
  end
  
  def after_sign_in_path_for(resource_or_scoped)
    if session[:previous_url] =~ /users\/invitation\/accept\?invitation_token/ || session[:previous_url] == '/'
      main_path
    else
      session[:previous_url] || main_path
    end
  end

  private

  def current_account
    if current_user.user_accounts.where(active: true).count >= 1
      session[:account] = current_user.user_accounts.first.account_id if session[:account].nil?
      current_user.user_accounts.find_by_account_id(session[:account]).account
    else
      nil
    end
  end
  helper_method :current_account
  
  def scope_current_account
    Account.current_id = current_account.id if current_user && current_user.user_accounts.where(active: true).count >= 1
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
  
  def admin_user
    current_user.user_accounts.where('user_id = ? and account_id=?', current_user.id, current_account.id).first.admin
  end
  helper_method :admin_user
  
  def billing_user
    current_user.user_accounts.where('user_id = ? and account_id=?', current_user.id, current_account.id).first.billing
  end
  helper_method :billing_user
  
  def verify_account
    if !current_account
      flash[:alert] = "You must create or be added to an account to access this page."
      redirect_to root_path
    end
  end
  
end




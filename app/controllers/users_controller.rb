class UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :verify_account
  before_action :only_admin, only: [:edit, :update, :index, :destroy] 
  before_action :can_not_delete_owner, only: [:destroy]
  
  
  def index
    @users = current_account.users.where('active = ?', true)
    @user = User.new
  end
  
  def show
    @user = User.find(params[:id])
    @user_account = @user.user_accounts.find_by_account_id(current_account)
  end
  
  def edit
    @user = User.find(params[:id])
    @user_account = @user.user_accounts.find_by_account_id(current_account)
  end
  
  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      redirect_to @user, notice: 'User was successfully updated.'
    else
      render action: "edit" 
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user_account = @user.user_accounts(current_account).last
    @user_account.update_attributes(active: false, billing: false, admin: false)
    if @user == current_user
      session[:account] = nil
    end
    redirect_to users_url, notice: 'User was successfully deleted.'
  end
  
  def invite_user
    @users = current_account.users.where('active = ?', true)
    @user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
    if @user.valid?
      unless UserAccount.find_by(account_id: current_account.id, user_id: @user.id)
        UserAccount.create(account_id: current_account.id, user_id: @user.id)    
      end
      @user_account = @user.user_accounts.find_by_account_id(current_account)
      @user_account.active = true
      @user_account.save
      redirect_to users_path, notice: 'Successfully Invited User!'
    else
      render "index"
    end
  end
  
  private
    def can_not_delete_owner
      if params[:id] == current_account.owner_id.to_s
        flash[:alert] = "You are not able to delete the owner of this account."
        redirect_to :back
      end
    end
    
    def only_admin           
      if current_account.owner_id != current_user.id && !admin_user
        flash[:alert] = "You must be the account owner or admin user to access the users page."
        redirect_to root_path # halts request cycle
      end
    end   

    def user_params
      params.require(:user).permit(:name, :email, user_accounts_attributes: [:id, :admin, :billing] )
    end
    
end
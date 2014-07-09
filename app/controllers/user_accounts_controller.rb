class UserAccountsController < ApplicationController
  def invite_user
    @user = User.invite!(:email => params[:user][:email], :name => params[:user][:name])
    unless UserAccount.find_by(account_id: current_account.id, user_id: @user.id)
      UserAccount.create(account_id: current_account.id, user_id: @user.id)    
    end
    redirect_to users_path, notice: 'Successfully Invited User!'
  end
end
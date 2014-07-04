class UsersController < ApplicationController
  before_action only: [:edit, :update, :index, :destroy] do
    only_owners("Users")
  end
  before_action :can_not_delete_owner, only: [:destroy]
  
  
  def index
    @users = current_account.users.all
    @user = User.new
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    redirect_to users_url, notice: 'User was successfully deleted.'
  end
  
  private
    def can_not_delete_owner
      if params[:id] == current_account.owner_id.to_s
        flash[:alert] = "You are not able to delete the owner of this account."
        redirect_to :back
      end
  end
end
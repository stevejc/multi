class UsersController < ApplicationController
  before_action :only_owners, only: [ :edit, :update, :index, :destroy ]
  
  def index
    @users = current_account.users.all
    @user = User.new
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully deleted.' }
      format.json { head :no_content }
    end
  end
  
  private
    def only_owners             
      if current_account.owner_id != current_user.id
        flash[:alert] = "You must be the account owner to access the Users page."
        redirect_to root_path # halts request cycle
      end
    end
    

    
end
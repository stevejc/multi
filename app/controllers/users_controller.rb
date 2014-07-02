class UsersController < ApplicationController
  before_action :only_owners, only: [ :edit, :update, :index ]
  
  def index
    @users = current_account.users.all

  end
  
  private
    def only_owners             
      if current_account.owner_id != current_user.id
        flash[:alert] = "You must be the account owner to access the Users page."
        redirect_to root_path # halts request cycle
      end
    end
end
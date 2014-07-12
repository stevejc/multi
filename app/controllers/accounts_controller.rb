class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:add_another_account] 
  before_action only: [:edit, :update] do
    only_owners("Settings")
  end
  
  def add_another_account
    @account = Account.new(plan: params[:plan])
    render 'new'
  end
  
  def new
    @account = Account.new(plan: params[:plan])
    unless current_user
      @account.build_owner
    end
  end
  
  def create
    @account = Account.new(account_params)
    @account.owner_id = current_account.owner_id if current_account
    @user_account = UserAccount.new()
    if @account.save
      UserAccount.create(account_id: @account.id, user_id: @account.owner_id)
      redirect_to root_path, notice: 'Successfully Created Account!'
    else
      render action: 'new'
    end
  end
  
  def edit
    @account = current_account
  end
  
  def update
    @account = Account.find(params[:id])
    respond_to do |format|
      if @account.update_attributes(account_params)
        format.html { redirect_to edit_account_path(@account), notice: 'Settings were successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def change_account
    if current_user.user_accounts.any? {|h| h[:account_id] == params[:user_account][:id].to_i}
      session[:account] = params[:user_account][:id]
      flash[:notice]= 'Successfully Changed Account!'
    else
      flash[:alert]= 'No access to this Account!'
    end
    redirect_to users_path
  end

  private
    def account_params
      params.require(:account).permit(:name, :plan, :email, :phone, :address, owner_attributes: [:account_id, :name, :email, :password, :password_confirmation])
    end
    
end
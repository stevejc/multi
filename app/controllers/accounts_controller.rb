class AccountsController < ApplicationController
  before_action :authenticate_user!, only: [:add_another_account] 
  before_action :only_billing, only: [:edit, :update]

  
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
    @account.owner_id = current_account.owner_id if current_user
    @user_account = UserAccount.new()
    if @account.save
      UserAccount.create(account_id: @account.id, user_id: @account.owner_id)
      session[:account] = @account.id
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
  
  def destroy
    @account = Account.find(params[:id])
    @account.destroy
    session.delete(:account)
    if current_user.user_accounts.count == 0
      current_user.destroy
      flash[:notice]= 'Your Account and User ID were successfully deleted.'
    else
      flash[:notice]= 'Account was successfully deleted.'
    end
    redirect_to root_url
  end

  private
    def account_params
      params.require(:account).permit(:owner_id, :name, :plan, :email, :phone, :address, owner_attributes: [:account_id, :name, :email, :password, :password_confirmation])
    end
    
    def only_billing            
      if current_account.owner_id != current_user.id && !current_user.user_accounts.where('user_id = ? and account_id=?', current_user.id, current_account.id).first.billing
        flash[:alert] = "You must be the account owner or billing liaison to access the settings page."
        redirect_to root_path # halts request cycle
      end
    end
    
end
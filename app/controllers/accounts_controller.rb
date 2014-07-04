class AccountsController < ApplicationController
  before_action only: [:edit, :update] do
    only_owners("Settings")
  end
  
  def new
    @account = Account.new(plan: params[:plan])
    @account.build_owner
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      @account.owner.update(account_id: @account.id) 
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

  private
    def account_params
      params.require(:account).permit(:name, :plan, :email, :phone, :address, owner_attributes: [:account_id, :email, :password, :password_confirmation])
    end
    
end
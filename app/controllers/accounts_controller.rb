class AccountsController < ApplicationController
  def new
    @account = Account.new
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

  private
    def account_params
      params.require(:account).permit(:name, owner_attributes: [:account_id, :email, :password, :password_confirmation])
    end
end
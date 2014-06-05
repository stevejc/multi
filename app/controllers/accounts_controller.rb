class AccountsController < ApplicationController
  def new
    @account = Account.new
  end
  
  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to root_path, notice: 'Successfully Created Account!'
    else
      render action: 'new'
    end
  end

private
  def account_params
    params.require(:account).permit(:subdomain, :name)
  end
end
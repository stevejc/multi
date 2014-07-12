class AddUserTypesToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :admin, :boolean, null: false, default: false
    add_column :user_accounts, :billing, :boolean,  null: false, default: false
  end
end

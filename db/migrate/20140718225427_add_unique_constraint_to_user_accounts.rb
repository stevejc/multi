class AddUniqueConstraintToUserAccounts < ActiveRecord::Migration
  def change
    add_column :user_accounts, :active, :boolean, null: false, default: true
    remove_index :user_accounts, name: "index_user_accounts_on_account_id"
    remove_index :user_accounts, name: "index_user_accounts_on_user_id"
    add_index :user_accounts, [:account_id, :user_id], unique: true
  end
end

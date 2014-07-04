class RemoveSubdomainFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :subdomain, :string
  end
end

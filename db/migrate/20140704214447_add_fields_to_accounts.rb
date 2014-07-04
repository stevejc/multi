class AddFieldsToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :phone, :string
    add_column :accounts, :email, :string
    add_column :accounts, :address, :text
  end
end

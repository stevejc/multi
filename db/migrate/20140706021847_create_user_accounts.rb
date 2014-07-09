class CreateUserAccounts < ActiveRecord::Migration
  def change
    create_table :user_accounts do |t|
      t.references :account, index: true
      t.references :user, index: true
    end
  end
end

class AddPlanToAccounts < ActiveRecord::Migration
  def change
    add_column :accounts, :plan, :string, null: false, default: "gold"
  end
end

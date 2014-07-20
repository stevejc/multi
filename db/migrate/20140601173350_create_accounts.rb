class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name,      null: false
      t.string :subdomain, unique: true
      t.integer :owner_id, null: false, unique: true

      t.timestamps
    end
  end
end

class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.string :subdomain, unique: true
      t.integer :owner_id, unique: true

      t.timestamps
    end
  end
end

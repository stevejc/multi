class CreateClients < ActiveRecord::Migration
  def change
    create_table :clients do |t|
      t.string :name, null: false
      t.text :address
      t.references :account, index: true

      t.timestamps
    end
  end
end

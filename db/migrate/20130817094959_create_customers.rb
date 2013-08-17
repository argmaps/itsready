class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.integer :user_id, null: false
      t.string :first_name, null: false
      t.string :last_name, null: false
      t.integer :country_code, null: false, limit: 4
      t.integer :phone, null: false

      t.timestamps
    end
  end
end

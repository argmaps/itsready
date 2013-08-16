class CreateCustomers < ActiveRecord::Migration
  def change
    create_table :customers do |t|
      t.string :first_name, :null => false
      t.string :last_name, :null => false
      t.string :country_code
      t.string :phone_number, :null => false
    end
  end
end

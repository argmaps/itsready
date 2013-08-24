class AddCountryToUsers < ActiveRecord::Migration
  def change
    add_column :users, :country, :string, nil: false
  end
end

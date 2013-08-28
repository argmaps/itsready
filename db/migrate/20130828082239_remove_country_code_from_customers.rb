class RemoveCountryCodeFromCustomers < ActiveRecord::Migration
  def change
    remove_column :customers, :country_code, :integer
  end
end

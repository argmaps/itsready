class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.integer :customer_id, :null => false
      t.integer :user_id, :null => false
      t.string :message, :null => false, :limit => 160
      t.boolean :ready, :default => false
      t.datetime :sent_at

      t.timestamps
    end
  end
end

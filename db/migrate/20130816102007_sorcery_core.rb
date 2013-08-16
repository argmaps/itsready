class SorceryCore < ActiveRecord::Migration
  def self.up
    create_table :users do |t|
      t.string :company,          :null => false
      t.string :email,            :null => false
      t.string :crypted_password, :default => nil, :null => false
      t.string :salt,             :default => nil, :null => false

      t.timestamps
    end
  end

  def self.down
    drop_table :users
  end
end

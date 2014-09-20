class ChangeMessageBodyColumnToTextAndExpand < ActiveRecord::Migration
  def change
    change_column :notifications, :message, :text, limit: 1600
  end
end

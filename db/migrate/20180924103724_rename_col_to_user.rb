class RenameColToUser < ActiveRecord::Migration[5.2]
  def change
  	remove_column :users, :blocked
  	add_column :users, :blocked, :boolean, default: 0
  end
end

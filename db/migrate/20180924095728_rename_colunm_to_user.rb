class RenameColunmToUser < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :last_active_at, :blocked
  	remove_column :users, :blocked
  	add_column :users, :blocked, :integer
  end
end

class RenameColunmToUser < ActiveRecord::Migration[5.2]
  def change
  	rename_column :users, :last_active_at, :blocked
  	change_column :users, :blocked, :integer
  end
end

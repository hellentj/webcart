class RenameColToUser < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :blocked, :boolean, default: 0
  end
end

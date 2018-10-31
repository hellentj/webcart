class RenameColumnOfUser < ActiveRecord::Migration[5.2]
  def change
  	change_column :users, :blocked, :integer, default: 0
  end
end

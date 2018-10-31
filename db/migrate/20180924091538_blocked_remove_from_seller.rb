class BlockedRemoveFromSeller < ActiveRecord::Migration[5.2]
  def change
  	remove_column :sellers, :blocked
  end
end

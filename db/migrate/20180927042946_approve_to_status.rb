class ApproveToStatus < ActiveRecord::Migration[5.2]
  def change
  	remove_column :sellers, :approved
  	add_column :sellers, :status, :integer
  end
end

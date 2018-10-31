class ApproveToStatus < ActiveRecord::Migration[5.2]
  def change
  	rename_column :sellers, :approved, :status
  	change_column :sellers, :status, :integer
  end
end

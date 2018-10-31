class StatusAddToSeller < ActiveRecord::Migration[5.2]
  def change
  	rename_column :sellers, :status, :approved
  end
end

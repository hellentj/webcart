class StatusToSeller < ActiveRecord::Migration[5.2]
  def change
  	add_column :sellers, :status, :string
  	add_column :sellers, :blocked, :string
  end
end

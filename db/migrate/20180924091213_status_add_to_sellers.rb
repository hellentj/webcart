class AddStatusToSeller < ActiveRecord::Migration[5.2]
  def change
    add_column :sellers, :status, :string
  end
end
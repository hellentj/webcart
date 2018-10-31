class AddSoldcountToProduct < ActiveRecord::Migration[5.2]
  def change
  	add_column :products, :sold, :integer, default: 0
  end
end

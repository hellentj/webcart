class RenameQuantityToCart < ActiveRecord::Migration[5.2]
  def change
  	rename_column :carts, :quantity, :total_quantity
  end
end

class ChangeDefToCart < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:carts, :quantity, 0)
  end
end

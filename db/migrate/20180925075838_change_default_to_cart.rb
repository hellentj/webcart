class ChangeDefaultToCart < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:carts, :quantity, nil)
  end
end

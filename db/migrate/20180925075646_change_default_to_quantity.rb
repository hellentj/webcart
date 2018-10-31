class ChangeDefaultToQuantity < ActiveRecord::Migration[5.2]
  def change
  	change_column_default(:quantities, :quantity, nil)
  end
end

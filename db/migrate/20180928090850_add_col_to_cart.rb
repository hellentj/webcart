class AddColToCart < ActiveRecord::Migration[5.2]
  def change
  	add_column :carts, :order_id, :integer
  end
end

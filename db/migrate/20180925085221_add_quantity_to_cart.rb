class AddQuantityToCart < ActiveRecord::Migration[5.2]
  def change
  	add_reference :carts, :quantity, index: true
  end
end

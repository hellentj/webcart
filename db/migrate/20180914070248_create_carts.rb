class CreateCarts < ActiveRecord::Migration[5.2]
  def change
    create_table :carts do |t|
      t.belongs_to :customer, index: true
      t.belongs_to :product, index: true
      t.integer :quantity, default: 1
      t.string :price
      t.boolean :check_out, default: false
      t.timestamps
    end
  end
end

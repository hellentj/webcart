class CreateProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.belongs_to :category
      t.belongs_to :seller
      t.string :product_name
      t.text :about
      t.integer :price
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end

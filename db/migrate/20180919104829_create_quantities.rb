class CreateQuantities < ActiveRecord::Migration[5.2]
  def change
    create_table :quantities do |t|
      t.belongs_to :product
      t.belongs_to :size
      t.belongs_to :colour
      t.integer :quantity, default: 0
      t.timestamps
    end
  end
end

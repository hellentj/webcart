class CreateOrders < ActiveRecord::Migration[5.2]
  def change
    create_table :orders do |t|
      t.belongs_to :payment, index: true
      t.belongs_to :address, index: true
      t.belongs_to :customer, index: true
      t.string :total_price
      t.timestamps
    end
  end
end

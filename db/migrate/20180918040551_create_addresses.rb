class CreateAddresses < ActiveRecord::Migration[5.2]
  def change
    create_table :addresses do |t|
      t.belongs_to :customer
      t.text :address
      t.string :city
      t.string :district
      t.string :state
      t.string :country
      t.string :pincode
      t.timestamps
    end
  end
end

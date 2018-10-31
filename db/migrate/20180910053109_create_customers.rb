class CreateCustomers < ActiveRecord::Migration[5.2]
  def change
    create_table :customers do |t|
      t.string :first_name
      t.string :last_name      
      t.string :gender
      t.date :DOB
      t.string :phone
      t.string :city
      t.belongs_to :user, index: true
      t.timestamps
    end
  end
end

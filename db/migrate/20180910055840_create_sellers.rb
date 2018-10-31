class CreateSellers < ActiveRecord::Migration[5.2]
  def change
    create_table :sellers do |t|
      t.belongs_to :user, index: true
      t.string :sname
      t.string :website
      t.text :description      
      t.timestamps
    end
  end
end

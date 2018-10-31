class CreateImages < ActiveRecord::Migration[5.2]
  def change
    create_table :images do |t|
      t.belongs_to :colour, index: true
      t.belongs_to :product, index:true
      t.string :image
      t.timestamps
    end
  end
end

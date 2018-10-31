class CreateColours < ActiveRecord::Migration[5.2]
  def change
    create_table :colours do |t|
      t.string :colour
      t.timestamps
    end
  end
end

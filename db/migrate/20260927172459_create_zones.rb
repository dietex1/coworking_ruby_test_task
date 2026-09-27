class CreateZones < ActiveRecord::Migration[7.2]
  def change
    create_table :zones do |t|
      t.string :name
      t.text :description
      t.integer :capacity

      t.timestamps
    end
  end
end

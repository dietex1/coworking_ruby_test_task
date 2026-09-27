class CreateRooms < ActiveRecord::Migration[7.2]
  def change
    create_table :roomes do |t|
      t.string :name
      t.text :description
      t.integer :capacity

      t.timestamps
    end
  end
end

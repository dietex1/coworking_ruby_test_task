class CreateReservations < ActiveRecord::Migration[7.2]
  def change
    create_table :reservations do |t|
      t.references :zone, null: false, foreign_key: true
      t.string :guest_name
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end

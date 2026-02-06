class CreateBookings < ActiveRecord::Migration[8.0]
  def change
    create_table :bookings do |t|
      t.string :pnr, null: false
      t.references :flight_instance, null: false, foreign_key: true

      t.timestamps
    end

    add_index :bookings, :pnr, unique: true
  end
end

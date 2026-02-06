class CreateTickets < ActiveRecord::Migration[8.0]
  def change
    create_table :tickets do |t|
      t.references :booking, null: false, foreign_key: true
      t.references :passenger, null: false, foreign_key: true
      t.references :flight_instance, null: false, foreign_key: true
      t.references :seat, null: false, foreign_key: true
      t.datetime :checked_in_at

      t.timestamps
    end

    add_index :tickets, [:flight_instance_id, :seat_id],
          unique: true,
          where: "seat_id IS NOT NULL",
          name: "index_tickets_on_fi_and_seat_unique"
        
    add_index :tickets, [:booking_id, :passenger_id], unique: true
  end
end

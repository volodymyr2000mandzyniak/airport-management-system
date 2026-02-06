class AddConstraintsForBookingsTicketsBoardingPassesBaggages < ActiveRecord::Migration[8.0]
  def change
    add_index :bookings, :pnr, unique: true

    add_index :tickets, [:flight_instance_id, :seat_id],
              unique: true,
              where: "seat_id IS NOT NULL",
              name: "index_tickets_on_flight_instance_and_seat_unique"

    remove_index :boarding_passes, :ticket_id if index_exists?(:boarding_passes, :ticket_id)
    add_index :boarding_passes, :ticket_id, unique: true

    add_index :baggages, :tag_number, unique: true
    add_check_constraint :baggages, "weight_kg > 0", name: "baggages_weight_positive"
  end
end

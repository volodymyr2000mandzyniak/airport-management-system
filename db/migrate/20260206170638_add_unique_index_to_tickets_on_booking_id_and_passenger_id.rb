class AddUniqueIndexToTicketsOnBookingIdAndPassengerId < ActiveRecord::Migration[8.0]
  def change
    add_index :tickets,
              [:booking_id, :passenger_id],
              unique: true,
              name: "index_tickets_on_booking_id_and_passenger_id_unique"
  end
end

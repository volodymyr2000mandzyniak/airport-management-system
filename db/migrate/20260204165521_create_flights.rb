class CreateFlights < ActiveRecord::Migration[8.0]
  def change
    create_table :flights do |t|
      t.references :airline, null: false, foreign_key: true
      t.string :flight_number, null: false

      t.bigint :origin_airport_id, null: false
      t.bigint :destination_airport_id, null: false

      t.timestamps
    end

    add_foreign_key :flights, :airports, column: :origin_airport_id
    add_foreign_key :flights, :airports, column: :destination_airport_id

    add_index :flights, [:airline_id, :flight_number], unique: true
    add_index :flights, :origin_airport_id
    add_index :flights, :destination_airport_id
  end
end

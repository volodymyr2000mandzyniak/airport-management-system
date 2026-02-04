class CreateFlightInstances < ActiveRecord::Migration[8.0]
  def change
    create_table :flight_instances do |t|
      t.references :flight, null: false, foreign_key: true

      t.datetime :scheduled_departure_at, null: false
      t.datetime :scheduled_arrival_at, null: false

      t.datetime :actual_departure_at
      t.datetime :actual_arrival_at

      t.integer :status, null: false

      t.timestamps
    end

    add_index :flight_instances, :status
    add_index :flight_instances, :scheduled_departure_at
  end
end

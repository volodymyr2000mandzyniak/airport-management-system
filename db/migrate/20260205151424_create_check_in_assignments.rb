class CreateCheckInAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :check_in_assignments do |t|
      t.references :flight_instance, null: false, foreign_key: true
      t.references :check_in_counter, null: false, foreign_key: true

      t.datetime :active_from, null: false
      t.datetime :active_to, null: false

      t.timestamps
    end

    add_check_constraint :check_in_assignments, "active_to > active_from", name: "check_in_assignments_active_range_valid"
  end
end

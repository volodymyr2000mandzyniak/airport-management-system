class CreateGateAssignments < ActiveRecord::Migration[8.0]
  def change
    create_table :gate_assignments do |t|
      t.references :flight_instance, null: false, foreign_key: true
      t.references :gate, null: false, foreign_key: true

      t.datetime :active_from, null: false
      t.datetime :active_to, null: false

      t.timestamps
    end

    add_check_constraint :gate_assignments, "active_to > active_from", name: "gate_assignments_active_range_valid"
  end
end

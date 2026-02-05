class AddExclusionConstraintsForResourceAssignments < ActiveRecord::Migration[8.0]
  def change
    enable_extension "btree_gist" unless extension_enabled?("btree_gist")

    execute <<~SQL
      ALTER TABLE gate_assignments
      ADD CONSTRAINT gate_assignments_no_overlapping_gate
      EXCLUDE USING gist (
        gate_id WITH =,
        tsrange(active_from, active_to, '[)') WITH &&
      );
    SQL

    execute <<~SQL
      ALTER TABLE check_in_assignments
      ADD CONSTRAINT check_in_assignments_no_overlapping_counter
      EXCLUDE USING gist (
        check_in_counter_id WITH =,
        tsrange(active_from, active_to, '[)') WITH &&
      );
    SQL
  end
end

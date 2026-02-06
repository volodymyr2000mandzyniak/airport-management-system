class FixBoardingPassesAndBaggages < ActiveRecord::Migration[8.0]
  def change
    # boarding_passes
    change_column_null :boarding_passes, :issued_at, false
    add_index :boarding_passes, :ticket_id, unique: true unless index_exists?(:boarding_passes, :ticket_id, unique: true)

    # baggages - tighten columns
    change_column_null :baggages, :tag_number, false
    change_column_null :baggages, :weight_kg, false

    add_index :baggages, :tag_number, unique: true unless index_exists?(:baggages, :tag_number, unique: true)
    add_check_constraint :baggages, "weight_kg > 0", name: "baggages_weight_positive" unless check_constraint_exists?(:baggages, name: "baggages_weight_positive")
  end
end

class CreateCheckInCounters < ActiveRecord::Migration[8.0]
  def change
    create_table :check_in_counters do |t|
      t.references :terminal, null: false, foreign_key: true
      t.string :code, null: false

      t.timestamps
    end

    add_index :check_in_counters, [:terminal_id, :code], unique: true
  end
end

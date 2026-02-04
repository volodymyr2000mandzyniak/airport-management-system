class CreateAircrafts < ActiveRecord::Migration[8.0]
  def change
    create_table :aircrafts do |t|
      t.references :airline, null: false, foreign_key: true
      t.string :model, null: false
      t.string :registration_number, null: false

      t.timestamps
    end

    add_index :aircrafts, :registration_number, unique: true
  end
end

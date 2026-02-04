class CreateAirports < ActiveRecord::Migration[8.0]
  def change
    create_table :airports do |t|
      t.string :name, null: false
      t.string :code, null: false
      t.string :iata_code
      t.string :icao_code

      t.timestamps
    end

    add_index :airports, :code, unique: true
    add_index :airports, :iata_code, unique: true, where: "iata_code IS NOT NULL"
    add_index :airports, :icao_code, unique: true, where: "icao_code IS NOT NULL"
  end
end

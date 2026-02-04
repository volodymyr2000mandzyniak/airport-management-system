# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2026_02_04_165531) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "aircrafts", force: :cascade do |t|
    t.bigint "airline_id", null: false
    t.string "model", null: false
    t.string "registration_number", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id"], name: "index_aircrafts_on_airline_id"
    t.index ["registration_number"], name: "index_aircrafts_on_registration_number", unique: true
  end

  create_table "airlines", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_airlines_on_code", unique: true
  end

  create_table "airports", force: :cascade do |t|
    t.string "name", null: false
    t.string "code", null: false
    t.string "iata_code"
    t.string "icao_code"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_airports_on_code", unique: true
    t.index ["iata_code"], name: "index_airports_on_iata_code", unique: true, where: "(iata_code IS NOT NULL)"
    t.index ["icao_code"], name: "index_airports_on_icao_code", unique: true, where: "(icao_code IS NOT NULL)"
  end

  create_table "check_in_counters", force: :cascade do |t|
    t.bigint "terminal_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["terminal_id", "code"], name: "index_check_in_counters_on_terminal_id_and_code", unique: true
    t.index ["terminal_id"], name: "index_check_in_counters_on_terminal_id"
  end

  create_table "flight_instances", force: :cascade do |t|
    t.bigint "flight_id", null: false
    t.datetime "scheduled_departure_at", null: false
    t.datetime "scheduled_arrival_at", null: false
    t.datetime "actual_departure_at"
    t.datetime "actual_arrival_at"
    t.integer "status", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flight_id"], name: "index_flight_instances_on_flight_id"
    t.index ["scheduled_departure_at"], name: "index_flight_instances_on_scheduled_departure_at"
    t.index ["status"], name: "index_flight_instances_on_status"
  end

  create_table "flights", force: :cascade do |t|
    t.bigint "airline_id", null: false
    t.string "flight_number", null: false
    t.bigint "origin_airport_id", null: false
    t.bigint "destination_airport_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airline_id", "flight_number"], name: "index_flights_on_airline_id_and_flight_number", unique: true
    t.index ["airline_id"], name: "index_flights_on_airline_id"
    t.index ["destination_airport_id"], name: "index_flights_on_destination_airport_id"
    t.index ["origin_airport_id"], name: "index_flights_on_origin_airport_id"
  end

  create_table "gates", force: :cascade do |t|
    t.bigint "terminal_id", null: false
    t.string "code", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["terminal_id", "code"], name: "index_gates_on_terminal_id_and_code", unique: true
    t.index ["terminal_id"], name: "index_gates_on_terminal_id"
  end

  create_table "seats", force: :cascade do |t|
    t.bigint "aircraft_id", null: false
    t.string "seat_number", null: false
    t.integer "cabin_class", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["aircraft_id", "seat_number"], name: "index_seats_on_aircraft_id_and_seat_number", unique: true
    t.index ["aircraft_id"], name: "index_seats_on_aircraft_id"
  end

  create_table "terminals", force: :cascade do |t|
    t.bigint "airport_id", null: false
    t.string "code", null: false
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["airport_id", "code"], name: "index_terminals_on_airport_id_and_code", unique: true
    t.index ["airport_id"], name: "index_terminals_on_airport_id"
  end

  add_foreign_key "aircrafts", "airlines"
  add_foreign_key "check_in_counters", "terminals"
  add_foreign_key "flight_instances", "flights"
  add_foreign_key "flights", "airlines"
  add_foreign_key "flights", "airports", column: "destination_airport_id"
  add_foreign_key "flights", "airports", column: "origin_airport_id"
  add_foreign_key "gates", "terminals"
  add_foreign_key "seats", "aircrafts"
  add_foreign_key "terminals", "airports"
end

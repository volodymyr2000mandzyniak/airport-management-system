class AddAircraftToFlightInstances < ActiveRecord::Migration[8.0]
  def change
    # 1) Додаємо поле поки що nullable, щоб міграція пройшла на існуючих даних
    add_reference :flight_instances, :aircraft, null: true, foreign_key: true

    # 2) Спробуємо підставити aircraft для існуючих записів, якщо в базі є хоч 1 aircraft
    reversible do |dir|
      dir.up do
        aircraft_id = execute("SELECT id FROM aircrafts ORDER BY id LIMIT 1").first&.fetch("id", nil)
        if aircraft_id
          execute("UPDATE flight_instances SET aircraft_id = #{aircraft_id} WHERE aircraft_id IS NULL")
        end
      end
    end

    # 3) Тепер робимо NOT NULL
    change_column_null :flight_instances, :aircraft_id, false
    add_reference :flight_instances, :aircraft, null: false, foreign_key: true
  end  
end

class CreateBaggages < ActiveRecord::Migration[8.0]
  def change
    create_table :baggages do |t|
      t.references :ticket, null: false, foreign_key: true
      t.string :tag_number, null: false
      t.decimal :weight_kg, null: false

      t.timestamps
    end

    add_index :baggages, :tag_number, unique: true
    add_check_constraint :baggages, "weight_kg > 0", name: "baggages_weight_positive"
  end
end

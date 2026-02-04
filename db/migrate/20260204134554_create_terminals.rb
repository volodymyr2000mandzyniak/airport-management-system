class CreateTerminals < ActiveRecord::Migration[8.0]
  def change
    create_table :terminals do |t|
      t.references :airport, null: false, foreign_key: true
      t.string :code, null: false
      t.string :name, null: false

      t.timestamps
    end

    add_index :terminals, [:airport_id, :code], unique: true 
  end
end

class CreateGates < ActiveRecord::Migration[8.0]
  def change
    create_table :gates do |t|
      t.references :terminal, null: false, foreign_key: true
      t.string :code, null: false

      t.timestamps
    end
    
    add_index :gates, [:terminal_id, :code], unique: true
  end
end

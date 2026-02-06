class CreatePassengers < ActiveRecord::Migration[8.0]
  def change
    create_table :passengers do |t|
      t.string :first_name
      t.string :last_name
      t.string :document_number

      t.timestamps
    end
  end
end

class CreateBoardingPasses < ActiveRecord::Migration[8.0]
  def change
    create_table :boarding_passes do |t|
      t.references :ticket, null: false, foreign_key: true
      t.datetime :issued_at, null: false

      t.timestamps
    end

    add_index :boarding_passes, :ticket_id, unique: true
  end
end

class FixPassengersConstraints < ActiveRecord::Migration[8.0]
  def change
    change_column_null :passengers, :first_name, false
    change_column_null :passengers, :last_name, false
    change_column_null :passengers, :document_number, false

    add_index :passengers, :document_number, unique: true unless index_exists?(:passengers, :document_number, unique: true)
  end
end

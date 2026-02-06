class MakeIssuedAtNotNullOnBoardingPasses < ActiveRecord::Migration[8.0]
  def up
    execute "UPDATE boarding_passes SET issued_at = created_at WHERE issued_at IS NULL"
    change_column_null :boarding_passes, :issued_at, false
  end

  def down
    change_column_null :boarding_passes, :issued_at, true
  end
end

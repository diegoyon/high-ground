class AddDivisionToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :division, :string
  end
end

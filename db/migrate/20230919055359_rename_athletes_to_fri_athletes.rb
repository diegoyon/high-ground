class RenameAthletesToFriAthletes < ActiveRecord::Migration[7.0]
  def change
    rename_table :athletes, :fri_athletes
  end
end

class RenameFriRecurrenteAthletesToFriRecurrenteCheckouts < ActiveRecord::Migration[7.0]
  def change
    rename_table :fri_athletes, :fri_checkouts
    rename_table :recurrente_athletes, :recurrente_checkouts
  end
end

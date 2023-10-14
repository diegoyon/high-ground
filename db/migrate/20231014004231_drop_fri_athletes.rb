class DropFriAthletes < ActiveRecord::Migration[7.0]
  def change
    drop_table :fri_athletes
  end
end

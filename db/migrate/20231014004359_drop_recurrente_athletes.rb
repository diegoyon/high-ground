class DropRecurrenteAthletes < ActiveRecord::Migration[7.0]
  def change
    drop_table :recurrente_athletes
  end
end

class AddRankAndPointsToAthletes < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :rank, :integer
    add_column :athletes, :total_points, :integer, default: 0
  end
end

class AddPointsAndRankToScores < ActiveRecord::Migration[7.0]
  def change
    add_column :scores, :points, :integer
    add_column :scores, :rank, :integer
  end
end

class ChangeScoreTypeToInteger < ActiveRecord::Migration[7.0]
  def change
    remove_column :scores, :main_score
    remove_column :scores, :tiebreak_score
    add_column :scores, :main_score, :integer
    add_column :scores, :tiebreak_score, :integer
  end
end

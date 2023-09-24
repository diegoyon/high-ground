class RefactorScoreColumns < ActiveRecord::Migration[7.0]
  def change
    remove_column :scores, :score_data
    add_column :scores, :main_score, :string
    add_column :scores, :tiebreak_score, :string
  end
end

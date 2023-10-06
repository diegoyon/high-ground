class RemoveScoreIdFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :workouts, :score, null: false, foreign_key: true
  end
end

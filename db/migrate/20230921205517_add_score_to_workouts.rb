class AddScoreToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_reference :workouts, :score, null: false, foreign_key: true
  end
end

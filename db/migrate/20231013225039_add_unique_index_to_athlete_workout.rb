class AddUniqueIndexToAthleteWorkout < ActiveRecord::Migration[7.0]
  def change
    add_index :scores, [:athlete_id, :workout_id], unique: true
  end
end

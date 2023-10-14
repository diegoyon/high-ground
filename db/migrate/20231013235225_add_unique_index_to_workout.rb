class AddUniqueIndexToWorkout < ActiveRecord::Migration[7.0]
  def change
    add_index :workouts, :workout_number, unique: true
  end
end

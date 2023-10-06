class AddWorkoutNumberToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :workout_number, :integer
  end
end

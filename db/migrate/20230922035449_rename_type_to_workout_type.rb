class RenameTypeToWorkoutType < ActiveRecord::Migration[7.0]
  def change
    rename_column :workouts, :type, :workout_type
  end
end

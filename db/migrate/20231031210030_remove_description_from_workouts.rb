class RemoveDescriptionFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_column :workouts, :description
  end
end

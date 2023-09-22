class RemoveAthleteIdFromWorkouts < ActiveRecord::Migration[7.0]
  def change
    remove_reference :workouts, :athlete, null: false, foreign_key: true
  end
end

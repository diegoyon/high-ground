class AddTiebreakTypeToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :tiebreak_type, :string
  end
end

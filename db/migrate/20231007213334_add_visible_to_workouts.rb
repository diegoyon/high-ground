class AddVisibleToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :visible, :boolean, default: false
  end
end

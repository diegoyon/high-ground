class AddTimeCapToWorkouts < ActiveRecord::Migration[7.0]
  def change
    add_column :workouts, :time_cap, :integer
  end
end

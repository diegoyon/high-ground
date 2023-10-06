class CreateWorkouts < ActiveRecord::Migration[7.0]
  def change
    create_table :workouts do |t|
      t.string :name
      t.text :description
      t.string :type
      t.references :athlete, null: false, foreign_key: true

      t.timestamps
    end
  end
end

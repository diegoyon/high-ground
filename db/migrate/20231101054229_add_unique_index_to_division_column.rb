class AddUniqueIndexToDivisionColumn < ActiveRecord::Migration[7.0]
  def change
    add_index :descriptions, [:division, :workout_id], unique: true
  end
end

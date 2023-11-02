class AddUniqueIndexToDivisionColumn < ActiveRecord::Migration[7.0]
  def change
    add_index :divisions, [:name, :workout_id], unique: true
  end
end

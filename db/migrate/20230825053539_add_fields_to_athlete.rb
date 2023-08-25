class AddFieldsToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :tshirt_size, :string
    add_column :athletes, :box, :string
  end
end

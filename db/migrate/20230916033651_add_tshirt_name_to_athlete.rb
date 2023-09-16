class AddTshirtNameToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :tshirt_name, :string
  end
end

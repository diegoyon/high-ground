class CreateNewAthletesTable < ActiveRecord::Migration[7.0]
  def change
    create_table :athletes do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :tshirt_size
      t.string :tshirt_name
      t.string :box
      t.string :division

      t.timestamps
    end
  end
end

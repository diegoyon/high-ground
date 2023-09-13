class CreateRecurrenteAthletes < ActiveRecord::Migration[7.0]
  def change
    create_table :recurrente_athletes do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :tshirt_size
      t.string :box
      t.string :division
      t.string :payment_status

      t.timestamps
    end
  end
end

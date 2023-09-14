class AddCheckoutToRecurrenteAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :recurrente_athletes, :checkout_id, :string
  end
end

class CreateRecurrenteCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :recurrente_checkouts do |t|
      t.string :checkout_id
      t.timestamps
    end
  end
end

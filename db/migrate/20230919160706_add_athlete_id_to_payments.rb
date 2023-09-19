class AddAthleteIdToPayments < ActiveRecord::Migration[7.0]
  def change
    add_reference :payments, :athlete, null: false, foreign_key: true
  end
end

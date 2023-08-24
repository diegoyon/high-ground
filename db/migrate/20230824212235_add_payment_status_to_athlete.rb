class AddPaymentStatusToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :payment_status, :string
  end
end

class AddPaymentRequestIdToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :payment_request_id, :string
  end
end

class AddFriRequestPaymentResponseToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :fri_request_payment_response, :jsonb
  end
end

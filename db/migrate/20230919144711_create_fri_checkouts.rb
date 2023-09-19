class CreateFriCheckouts < ActiveRecord::Migration[7.0]
  def change
    create_table :fri_checkouts do |t|
      t.string :fri_username
      t.integer :transaction_id
      t.jsonb :fri_request_payment_response
      t.jsonb :fri_transaction_status_response
      t.jsonb :fri_webhook_response
      t.timestamps
    end
  end
end

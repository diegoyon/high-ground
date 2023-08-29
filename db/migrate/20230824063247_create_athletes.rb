class CreateAthletes < ActiveRecord::Migration[7.0]
  def change
    create_table :athletes do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :phone
      t.string :fri_username
      t.string :tshirt_size
      t.string :box
      t.string :division
      t.string :payment_status
      t.integer :transaction_id
      t.jsonb :fri_request_payment_response
      t.jsonb :fri_transaction_status_response
      t.jsonb :fri_webhook_response

      t.timestamps
    end
  end
end

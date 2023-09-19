class RemoveFriTransactionREsponseFromFriCheckout < ActiveRecord::Migration[7.0]
  def change
    remove_column :fri_checkouts, :fri_transaction_status_response, :jsonb
  end
end

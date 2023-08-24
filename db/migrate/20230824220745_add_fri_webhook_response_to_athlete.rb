class AddFriWebhookResponseToAthlete < ActiveRecord::Migration[7.0]
  def change
    add_column :athletes, :fri_webhook_response, :jsonb
  end
end

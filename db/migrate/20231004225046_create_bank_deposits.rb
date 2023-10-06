class CreateBankDeposits < ActiveRecord::Migration[7.0]
  def change
    create_table :bank_deposits do |t|
      t.integer :amount, null: false, default: 0
      t.timestamps
    end
  end
end

class CreatePayments < ActiveRecord::Migration[7.0]
  def change
    create_table :payments do |t|
      t.string :payment_status
      t.references :payable, polymorphic: true, null: false
      t.timestamps
    end
  end
end

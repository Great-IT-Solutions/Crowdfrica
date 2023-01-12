class CreatePaypalPaymentLogs < ActiveRecord::Migration[6.0]
  def change
    create_table :paypal_payment_logs do |t|
      t.references :donation, null: false, foreign_key: true

      t.timestamps
    end
  end
end

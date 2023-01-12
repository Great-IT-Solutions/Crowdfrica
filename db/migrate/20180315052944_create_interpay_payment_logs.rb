class CreateInterpayPaymentLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :interpay_payment_logs do |t|
      t.integer :donation_id
      t.text    :payment_log

      t.timestamps
    end
  end
end

class CreateRavePaymentLogs < ActiveRecord::Migration[5.0]
  def change
    create_table :rave_payment_logs do |t|
      t.integer :donation_id
      t.text    :payment_log
      t.timestamps
    end
    add_index :rave_payment_logs, :donation_id
  end
end

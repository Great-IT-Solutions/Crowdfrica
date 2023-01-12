class ChangePaypalPaymentlogidToSerial < ActiveRecord::Migration[6.0]
  def change
    change_column :paypal_payment_logs, :id, :bigint, auto_increment: true
  end
end

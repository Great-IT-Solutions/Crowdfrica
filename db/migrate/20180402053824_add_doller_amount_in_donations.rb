class AddDollerAmountInDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :ghs_amount, :numeric, default: 0
  end
end

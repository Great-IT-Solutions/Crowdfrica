class AddTipIntoDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :tip, :integer, default: 0
  end
end

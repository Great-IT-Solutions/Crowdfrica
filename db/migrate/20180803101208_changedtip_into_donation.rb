class ChangedtipIntoDonation < ActiveRecord::Migration[5.0]
  def change
    change_column :donations, :tip, :decimal
  end
end

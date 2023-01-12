class AddCurrencyConversionFilds < ActiveRecord::Migration[5.0]
  def change
    add_column :exrates, :ngn_rate, :numeric, null: false, default: 0.0
    add_column :exrates, :kes_rate, :numeric, null: false, default: 0.0
    add_column :donations, :ngn_amount, :numeric, default: 0
    add_column :donations, :kes_amount, :numeric, default: 0
    add_column :donations, :ngn_tips, :numeric, default: 0
    add_column :donations, :kes_tips, :numeric, default: 0
    add_column :donations, :ghs_tips, :numeric, default: 0
  end
end

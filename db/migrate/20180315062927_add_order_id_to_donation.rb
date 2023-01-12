class AddOrderIdToDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :order_id, :string, default: ''
    add_column :donations, :order_status, :string, default: ''
  end
end

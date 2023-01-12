class ChangeOrderIdDefault < ActiveRecord::Migration[6.0]
  def change
    change_column :donations, :order_id, :string, default: nil
  end
end

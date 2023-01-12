class AddSquareCustomerIdToDonors < ActiveRecord::Migration[6.0]
  def change
    add_column :donors, :square_customer_id, :string
  end
end

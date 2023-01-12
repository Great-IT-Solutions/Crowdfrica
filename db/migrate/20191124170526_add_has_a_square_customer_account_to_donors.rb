class AddHasASquareCustomerAccountToDonors < ActiveRecord::Migration[6.0]
  def change
    add_column :donors, :has_a_square_customer_account, :boolean, null: false, default: false
  end
end

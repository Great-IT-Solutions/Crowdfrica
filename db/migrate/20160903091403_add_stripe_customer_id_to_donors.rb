class AddStripeCustomerIdToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :stripe_customer_id, :string
  end
end

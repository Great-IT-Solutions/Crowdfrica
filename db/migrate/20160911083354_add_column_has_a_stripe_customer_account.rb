class AddColumnHasAStripeCustomerAccount < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :has_a_stripe_customer_account, :boolean, null: false, default: false
  end
end

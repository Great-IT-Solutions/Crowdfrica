class AddOmniauthToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :provider, :string
    add_column :donors, :uid, :string
  end
end

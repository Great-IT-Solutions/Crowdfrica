class RemoveAdminColumnFromDonors < ActiveRecord::Migration[5.0]
  def change
    remove_column :donors, :admin
  end
end

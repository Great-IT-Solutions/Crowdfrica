class AddAdminColumnToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :admin, :boolean, default: false
  end
end

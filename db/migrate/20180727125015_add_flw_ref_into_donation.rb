class AddFlwRefIntoDonation < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :flw_ref, :string
  end
end

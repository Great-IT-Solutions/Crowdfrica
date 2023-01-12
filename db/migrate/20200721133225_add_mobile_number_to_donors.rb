class AddMobileNumberToDonors < ActiveRecord::Migration[6.0]
  def change
    add_column :donors, :mobile_number, :string
    add_index :donors, :mobile_number, unique: true
  end
end

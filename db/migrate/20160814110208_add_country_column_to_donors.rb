class AddCountryColumnToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :country, :string
  end
end

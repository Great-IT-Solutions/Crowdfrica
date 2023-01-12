class AddGenderColumnToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :gender, :integer, default: 0
  end
end

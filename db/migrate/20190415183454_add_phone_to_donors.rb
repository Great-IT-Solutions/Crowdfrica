class AddPhoneToDonors < ActiveRecord::Migration[5.0]
  def change
    add_column :donors, :phone, :string
    change_column_default :donors, :gender, from: 0, to: nil
  end
end

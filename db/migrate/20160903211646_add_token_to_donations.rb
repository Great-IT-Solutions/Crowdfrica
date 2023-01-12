class AddTokenToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :token, :string
  end
end

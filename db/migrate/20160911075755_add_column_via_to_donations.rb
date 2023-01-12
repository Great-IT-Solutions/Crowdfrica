class AddColumnViaToDonations < ActiveRecord::Migration[5.0]
  def change
    add_column :donations, :via, :string
  end
end

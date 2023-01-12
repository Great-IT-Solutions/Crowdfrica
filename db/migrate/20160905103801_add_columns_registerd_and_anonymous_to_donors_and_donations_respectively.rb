class AddColumnsRegisterdAndAnonymousToDonorsAndDonationsRespectively < ActiveRecord::Migration[5.0]
  def change
    add_column :donors,    :registered, :boolean, null: false,  default: false
    add_column :donations, :anonymous,  :boolean, null: false,  default: false
  end
end

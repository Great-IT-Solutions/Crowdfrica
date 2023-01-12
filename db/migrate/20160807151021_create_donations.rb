class CreateDonations < ActiveRecord::Migration[5.0]
  def change
    create_table :donations do |t|
      t.numeric  :amount, null: false, default: 0
      t.timestamps
    end
  end
end

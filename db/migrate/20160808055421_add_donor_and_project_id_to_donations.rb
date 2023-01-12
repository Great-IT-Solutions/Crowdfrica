class AddDonorAndProjectIdToDonations < ActiveRecord::Migration[5.0]
  def change
    add_reference :donations, :donor,   foreign_key: true
    add_reference :donations, :project, foreign_key: true
  end
end

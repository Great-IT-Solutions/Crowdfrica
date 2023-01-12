class RemoveColumnBeneficiaryIdFromDonations < ActiveRecord::Migration[5.0]
  def change
    remove_column :donations, :beneficiary_id
  end
end

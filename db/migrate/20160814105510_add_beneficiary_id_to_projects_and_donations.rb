class AddBeneficiaryIdToProjectsAndDonations < ActiveRecord::Migration[5.0]
  def change
    add_reference :projects,  :beneficiary, foreign_key: true
    add_reference :donations, :beneficiary, foreign_key: true
  end
end

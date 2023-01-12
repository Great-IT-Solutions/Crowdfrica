class RemoveColumnAmountNeededAndAilmentOrEquipmentFromBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    remove_column :beneficiaries, :amount_needed
    remove_column :beneficiaries, :ailment_or_equipment_name
  end
end

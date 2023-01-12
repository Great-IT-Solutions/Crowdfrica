class CreateBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    create_table :beneficiaries do |t|
      t.integer  :type, null: false, default: 0
      t.string   :beneficiary_name, null: false, default: ''
      t.string   :ailment_or_equipment_name, null: false, default: ''
      t.numeric  :amount_needed, null: false, default: 0
      t.string   :country, null: false, default: ''

      t.timestamps
    end
  end
end

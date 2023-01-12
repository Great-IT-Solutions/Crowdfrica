class RenameColumnTypeToBtypeInBeneficiaries < ActiveRecord::Migration[5.0]
  def change
    rename_column :beneficiaries, :type, :btype
  end
end

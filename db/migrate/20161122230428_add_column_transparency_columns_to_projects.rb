class AddColumnTransparencyColumnsToProjects < ActiveRecord::Migration[5.0]
  def change
    # health insurance

    add_column :projects, :medical_cost,       :numeric, null: false, default: 0.0
    add_column :projects, :equipment_cost,     :numeric, null: false, default: 0.0

    add_column :projects, :year_cost,          :numeric, null: false, default: 0.0
    add_column :projects, :renewal,            :numeric, null: false, default: 0.0

    add_column :projects, :processing,         :numeric, null: false, default: 0.0
    add_column :projects, :operational_costs,  :numeric, null: false, default: 0.0
  end
end

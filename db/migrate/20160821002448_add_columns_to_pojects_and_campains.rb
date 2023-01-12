class AddColumnsToPojectsAndCampains < ActiveRecord::Migration[5.0]
  def change
    add_column  :projects,  :ailment_or_equipment, :string,  null: false, default: ''
    add_column  :projects,  :cost,                 :numeric, null: false, default: 0
    add_column  :projects,  :date_funded,          :date
    add_column  :campaigns, :published,            :boolean, null: false, default: false
  end
end

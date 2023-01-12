class RenameColumnNameInProjects < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :procect_name, :project_name
  end
end

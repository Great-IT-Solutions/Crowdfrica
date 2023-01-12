class RemoveColumnProjectHeadlineFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :project_headline
  end
end

class RemoveColumnProjectGoalFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :project_goal, :numeric
  end
end

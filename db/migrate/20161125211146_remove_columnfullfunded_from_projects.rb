class RemoveColumnfullfundedFromProjects < ActiveRecord::Migration[5.0]
  def change
    remove_column :projects, :fullfunded, :boolean
  end
end

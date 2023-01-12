class AddColumnFullyfundedToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :fullfunded, :boolean, null: false, default: false
  end
end

class RenameFaultyColumnnamesProjectHeadlineAndProjectDescriptionInProjects < ActiveRecord::Migration[5.0]
  def change
    rename_column :projects, :prgoject_headline,    :project_headline
    rename_column :projects, :prgoject_description, :project_description
  end
end

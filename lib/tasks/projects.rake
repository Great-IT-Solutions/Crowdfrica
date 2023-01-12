namespace :projects do
  desc 'Move Project description from projects table description column text to ActionText'
  task move_project_description_to_actiontext: :environment do
    @projects = Project.all.select('id', 'project_description AS description')
    @projects.each do |project|
      Project.find(project.id).update(project_description: project.description) if project.project_description.empty?
    end
  end
end

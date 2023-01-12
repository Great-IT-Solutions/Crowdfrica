class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string     :procect_name, null: false
      t.numeric    :project_goal
      t.text       :prgoject_headline
      t.text       :prgoject_description
      # t.datetime :expires_at

      t.timestamps
    end
  end
end

class AddColumnExpiresAtToProjects < ActiveRecord::Migration[5.0]
  def change
    add_column :projects, :expires_at, :date
  end
end

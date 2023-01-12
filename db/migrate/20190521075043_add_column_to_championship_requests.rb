class AddColumnToChampionshipRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :championship_requests, :authorized, :boolean, default: false
  end
end

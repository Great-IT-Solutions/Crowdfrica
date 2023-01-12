class AddDeclinedColumnToChampionshipRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :championship_requests, :declined, :boolean, default: false
  end
end

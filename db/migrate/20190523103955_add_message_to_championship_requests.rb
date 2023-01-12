class AddMessageToChampionshipRequests < ActiveRecord::Migration[5.0]
  def change
    add_column :championship_requests, :message, :text
  end
end

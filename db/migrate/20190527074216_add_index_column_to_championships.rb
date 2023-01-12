class AddIndexColumnToChampionships < ActiveRecord::Migration[5.0]
  def change
    add_index :championships, :champion_id, unique: true
    add_index :championships, :campaign_id, unique: true
  end
end

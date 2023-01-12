class CreateChampionshipRequests < ActiveRecord::Migration[5.0]
  def change
    create_table :championship_requests do |t|
      t.integer :champion_id, null: false
      t.integer :campaign_id, null: false
      t.text :reason
      t.string :relationship

      t.timestamps
    end
  end
end

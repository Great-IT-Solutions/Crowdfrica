class CreateChampionships < ActiveRecord::Migration[5.0]
  def change
    create_table :championships do |t|
      t.integer :champion_id, null: false
      t.integer :campaign_id, null: false
      t.string :relationship
      t.text :message

      t.timestamps
    end
  end
end

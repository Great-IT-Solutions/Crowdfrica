class CreateCampaigns < ActiveRecord::Migration[5.0]
  def change
    create_table :campaigns do |t|
      t.string :campaign_name,                  null: false, default: ''
      t.string :campaign_description,           null: false, default: ''
      t.string :campaign_description_image_url, null: false, default: ''
      t.string :campaign_description_video_url, nill: false, default: ''

      t.timestamps
    end
  end
end

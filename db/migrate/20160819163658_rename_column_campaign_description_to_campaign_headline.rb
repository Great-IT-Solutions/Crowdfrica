class RenameColumnCampaignDescriptionToCampaignHeadline < ActiveRecord::Migration[5.0]
  def change
    rename_column :campaigns, :campaign_description, :campaign_headline
    rename_column :campaigns, :campaign_description_image_url, :campaign_image_url
    rename_column :campaigns, :campaign_description_video_url, :campaign_video_url
  end
end

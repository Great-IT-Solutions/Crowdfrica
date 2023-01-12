class RemoveColumnCampaignFromCampaigns < ActiveRecord::Migration[5.0]
  def change
    remove_column :campaigns, :campaign_name
  end
end

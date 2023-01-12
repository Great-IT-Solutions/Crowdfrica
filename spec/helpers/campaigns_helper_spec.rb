RSpec.describe CampaignsHelper, type: :helper do
  let(:project) { build(:project, project_name: 'Big Project') }
  let(:campaign) { create(:campaign, project: project) }

  describe 'facebook_url' do
    it 'defines the url to share a campaign on facebook' do
      expected_result = "https://www.facebook.com/sharer/sharer.php?u=#{campaign_url(campaign.slug)}"
      expect(helper.facebook_url(campaign)).to eq(expected_result)
    end
  end

  describe 'twitter_url' do
    it 'defines the url to share a campaign on twitter' do
      expected_result = 'https://twitter.com/intent/tweet?' \
                        'text=Give%20now%21%20Big%20Project%20on&' \
                        "via=crowdfrica&url=#{campaign_url(campaign.slug)}&" \
                        'hashtags=startup,healthcare,healthinsurance,Africa'
      expect(helper.twitter_url(campaign)).to eq(expected_result)
    end
  end
end

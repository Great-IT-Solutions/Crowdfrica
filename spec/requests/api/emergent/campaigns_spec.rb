describe 'Campaigns API' do
  subject(:response_hash) { JSON.parse(response.body, symbolize_names: true) }

  let(:url) { '/api/emergent/campaigns' }
  let(:params) { { appId: emergent_app_id, appKey: emergent_app_key, limit: limit } }
  let(:limit) { nil }
  let!(:campaign) { create(:campaign_not_yet_funded, campaign_name: 'a' * 1000) }

  before do
    create(:campaign_fully_funded)
    create(:campaign_unpublished)
    get url, params: params
  end

  describe 'returns campaigns still in need of funds' do
    let(:expected_hash) do
      { status: 200, statusDescription: 'OK',
        data: [{ campaignCode: campaign.id.to_s, campaignName: campaign.campaign_name.truncate(65) }] }
    end

    it { is_expected.to eq expected_hash }
  end

  describe 'returns 0 campaigns when limit is set to 0' do
    let(:limit) { 0 }

    it { expect(response_hash[:data].length).to eq 0 }
  end

  describe 'invalid credentials' do
    let(:params) { { appId: emergent_app_id, appKey: 'invalid-key' } }
    let(:expected_hash) { { status: 401, statusDescription: 'Not authorized' } }

    it { is_expected.to eq expected_hash }
  end
end

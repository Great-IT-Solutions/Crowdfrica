describe 'Validate campaign code API' do
  subject { JSON.parse(response.body, symbolize_names: true) }

  let(:url) { '/api/emergent/validate_campaign' }
  let(:params) { { appId: emergent_app_id, appKey: emergent_app_key, campaignCode: campaign_code } }
  let(:campaign_not_yet_funded) { create(:campaign_not_yet_funded) }
  let(:campaign_fully_funded) { create(:campaign_fully_funded) }
  let(:campaign_unpublished) { create(:campaign_unpublished) }
  let(:expected_invalid_campaign_hash) { { isValid: false, status: 200, statusDescription: 'OK' } }

  before { get url, params: params }

  describe 'campaign still in need of funds' do
    let(:campaign_code) { campaign_not_yet_funded.id }
    let(:expected_hash) do
      { isValid: true, campaignName: campaign_not_yet_funded.campaign_name, status: 200, statusDescription: 'OK' }
    end

    it { is_expected.to eq expected_hash }
  end

  describe 'fully funded campaign' do
    let(:campaign_code) { campaign_fully_funded.id }

    it { is_expected.to eq expected_invalid_campaign_hash }
  end

  describe 'unpublished campaign' do
    let(:campaign_code) { campaign_unpublished.id }

    it { is_expected.to eq expected_invalid_campaign_hash }
  end

  describe 'non-existent campaign' do
    let(:campaign_code) { 12_334_222 }

    it { is_expected.to eq expected_invalid_campaign_hash }
  end

  describe 'no campaign code param' do
    let(:params) { { appId: emergent_app_id, appKey: emergent_app_key } }
    let(:expected_hash) do
      { status: 422, statusDescription: 'param is missing or the value is empty: campaignCode' }
    end

    it { is_expected.to eq expected_hash }
  end

  describe 'invalid credentials' do
    let(:campaign_code) { campaign_not_yet_funded.id }
    let(:params) { { appId: emergent_app_id, appKey: 'invalid-key', campaignCode: campaign_code } }
    let(:expected_hash) { { status: 401, statusDescription: 'Not authorized' } }

    it { is_expected.to eq expected_hash }
  end
end

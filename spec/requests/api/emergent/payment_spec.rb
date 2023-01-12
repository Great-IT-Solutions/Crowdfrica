describe 'Payment callback API' do
  subject { JSON.parse(response.body, symbolize_names: true) }

  let(:url) { '/api/emergent/payment' }
  let(:params) do
    { appId: emergent_app_id, appKey: emergent_app_key, campaignCode: campaign_code,
      paymentReference: payment_reference, mobileNumber: '0771 343434', amount: amount,
      fullname: fullname }
  end
  let(:campaign) { create(:campaign_not_yet_funded) }
  let(:campaign_code) { campaign.id }
  let(:payment_reference) { '6549222' }
  let(:amount) { 2000 }
  let(:fullname) { nil }
  let(:success_hash) { { status: 200, statusDescription: 'OK' } }

  before { post url, params: params }

  describe 'Successful emergent donation creation' do
    it { is_expected.to eq success_hash }

    it { expect(campaign.project.donations.where(via: 'emergent').count).to eq 1 }
  end

  describe 'Successful emergent donation and donor creation with fullname' do
    let(:fullname) { 'Kwame Nkrumah' }

    it { is_expected.to eq success_hash }

    it do
      donation = campaign.project.donations.where(via: 'emergent').last
      expect(donation.donor.attributes).to include({ 'fullname' => fullname })
    end
  end

  describe 'non-existent campaign' do
    let(:campaign_code) { 12_334_222 }
    let(:expected_hash) { { status: 422, statusDescription: 'Invalid campaignCode' } }

    it { is_expected.to eq expected_hash }
  end

  describe 'invalid amount' do
    let(:amount) { 'invalid' }
    let(:expected_hash) { { status: 422, statusDescription: 'amount is not a number' } }

    it { is_expected.to eq expected_hash }
  end

  describe 'no payment reference param' do
    let(:payment_reference) { '' }
    let(:expected_hash) do
      { status: 422, statusDescription: 'param is missing or the value is empty: paymentReference' }
    end

    it { is_expected.to eq expected_hash }
  end

  describe 'invalid credentials' do
    let(:params) { { appId: emergent_app_id, appKey: 'invalid-key' } }
    let(:expected_hash) { { status: 401, statusDescription: 'Not authorized' } }

    it { is_expected.to eq expected_hash }
  end
end

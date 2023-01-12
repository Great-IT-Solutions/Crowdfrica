require 'rails_helper'

describe EmergentPayment do
  let(:service_call) { described_class.call!(campaign, attributes) }
  let(:attributes) do
    { payment_reference: payment_reference, mobile_number: mobile_number, amount: amount, fullname: fullname }
  end
  let(:campaign) { FactoryBot.create(:campaign_not_yet_funded) }
  let(:payment_reference) { '23333' }
  let(:mobile_number) { '07771 2345 7282' }
  let(:amount) { 2000 }
  let(:fullname) { '' }
  let(:donation) { campaign.project.donations.first }
  let!(:exrate) { create(:exrate, rate: 6) }

  before do
    FactoryBot.create(:exrate, rate: 6)
  end

  it 'creates a donation' do
    expect { service_call }.to change { campaign.project.donations.count }.from(0).to(1)
  end

  it 'populates the donation attributes' do
    service_call
    expected_hash = { amount: Exrate.convert_to_usd(amount), ghs_amount: amount, order_id: payment_reference,
                      via: 'emergent', anonymous: false }.stringify_keys
    expect(donation.attributes).to include expected_hash
  end

  it 'creates a donor' do
    expect { service_call }.to change(Donor, :count).from(0).to(1)
  end

  it 'populates the donor attributes' do
    service_call
    expected_hash = { fullname: mobile_number, phone: mobile_number,
                      email: "emergent.#{payment_reference}@crowdfrica.org" }.stringify_keys
    expect(donation.donor.attributes).to include expected_hash
  end

  context 'when the donor identitifed by mobile number already exists' do
    let(:fullname) { 'Kwamre Nkrumah' }

    before { FactoryBot.create(:donor, mobile_number: mobile_number) }

    it { expect { service_call }.not_to change(Donor, :count) }

    it 'updates fullname' do
      service_call
      expect(donation.donor.fullname).to eq fullname
    end
  end

  context 'when fullname is given' do
    let(:fullname) { 'Kwame Nkrumah' }

    it 'populates the donor attributes' do
      service_call
      expected_hash = { fullname: fullname, phone: mobile_number,
                        email: "emergent.#{payment_reference}@crowdfrica.org" }.stringify_keys
      expect(donation.donor.attributes).to include expected_hash
    end
  end

  context 'when amount is not a number' do
    let(:amount) { '2000e' }

    it { expect { service_call }.to raise_error(EmergentException, 'amount is not a number') }
  end

  context 'when mobile number has less than 4 characters', :aggregate_failures do
    let(:mobile_number) { '0771' }

    before { allow(Airbrake).to receive(:notify) }

    it do
      expect { service_call }.to raise_error(EmergentException,
                                             'Validation failed: Phone is too short (minimum is 5 characters)')
      expect(Airbrake).to have_received(:notify)
    end
  end
end

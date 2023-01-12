describe Donation do
  describe 'Associations' do
    it { is_expected.to have_many(:interpay_payment_logs) }
    it { is_expected.to have_many(:rave_payment_logs) }
    it { is_expected.to belong_to(:donor) }
  end

  describe 'Validations' do
    it { is_expected.to validate_uniqueness_of(:order_id).scoped_to(:via).allow_nil }
  end
end

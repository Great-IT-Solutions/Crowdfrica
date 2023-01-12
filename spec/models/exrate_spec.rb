describe Exrate do
  describe '#convert_amount' do
    before do
      FactoryBot.create(:exrate, rate: 1.258, ngn_rate: 2.5, kes_rate: 3)
    end

    it 'converts $US to GHS' do
      expect(described_class.convert_amount(2, 'GH')).to eq 2.52
    end

    it 'converts $US to NGN' do
      expect(described_class.convert_amount(3, 'NG')).to eq 7.50
    end

    it 'converts $US to KE' do
      expect(described_class.convert_amount(4.5, 'KE')).to eq 13.50
    end

    it 'converts $US to US' do
      expect(described_class.convert_amount(5.5, 'US')).to eq 5.5
    end

    it 'converts unknown to unknown' do
      expect(described_class.convert_amount(6.5, 'ZZ')).to eq 6.5
    end
  end

  describe '#convert_to_usd' do
    before do
      FactoryBot.create(:exrate, rate: 5)
    end

    it 'converts GH to $US' do
      expect(described_class.convert_to_usd(22.5)).to eq 4.5
    end
  end
end

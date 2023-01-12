describe Donor do
  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_presence_of(:fullname) }
  it { is_expected.to validate_presence_of(:password) }
  it { is_expected.to validate_length_of(:phone).is_at_least(5).is_at_most(15) }
  it { is_expected.to validate_uniqueness_of(:mobile_number) }

  context 'Associations' do
    it { is_expected.to have_many(:donations).dependent(:destroy) }
    it { is_expected.to have_many(:projects).through(:donations) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end

  describe '#profile_image?' do
    it 'returns boolean depending image presence' do
      donor_with_image = create(:donor, image: 'www.google.com')
      donor_without_image = create(:donor)

      expect(donor_with_image.profile_image?).to be_truthy
      expect(donor_without_image.profile_image?).to be_falsy
    end
  end

  describe '#initials' do
    it 'returns initial' do
      donor = create(:donor, fullname: 'Ciré Dia')
      donor2 = create(:donor, fullname: 'saliou Dia')

      expect(donor.initials).to eq('C')
      expect(donor2.initials).to eq('S')
    end
  end

  describe '#first_name' do
    it 'returns first name' do
      donor = create(:donor, fullname: 'Ciré Dia')

      expect(donor.first_name).to eq('Ciré')
    end
  end

  describe '#is_authenticated_from_facebook?' do
    it 'returns boolean whether the donor has logged in from facebook' do
      donor = create(:donor)
      expect(donor.is_authenticated_from_facebook?).to be_falsy
    end
  end
end

RSpec.describe Project do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:project_name) }
  end

  describe 'Associations' do
    it { is_expected.to belong_to(:category) }
    it { is_expected.to belong_to(:beneficiary) }
    it { is_expected.to have_one(:campaign).dependent(:destroy) }
    it { is_expected.to have_many(:donations).dependent(:destroy) }
    it { is_expected.to have_many(:donors).through(:donations) }
    it { is_expected.to have_many(:comments).dependent(:destroy) }
  end
end

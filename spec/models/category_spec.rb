RSpec.describe Category do
  describe 'Validations' do
    it { is_expected.to validate_presence_of(:category_name) }
    it { is_expected.to validate_presence_of(:category_description) }
  end

  describe 'Associations' do
    it { is_expected.to have_many(:projects).dependent(:destroy) }
  end
end

RSpec.describe BlogPost, type: :model do
  context 'when new blog is created' do
    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:summary) }
    it { is_expected.to validate_presence_of(:body) }
  end

  context 'when blog is created' do
    it { is_expected.to belong_to(:author).class_name('AdminUser') }
  end
end

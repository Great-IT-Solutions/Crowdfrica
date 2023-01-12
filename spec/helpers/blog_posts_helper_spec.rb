RSpec.describe BlogPostsHelper, type: :helper do
  before do
    helper.request.path = '/blog_posts'
  end

  context 'when on the blog index page' do
    describe 'active_class' do
      it "returns 'active' if the given path is for the current_page" do
        expect(helper.active_class('/blog_posts')).to eq('active')
      end

      it "returns 'nil' if the given path is not for the current_page" do
        expect(helper.active_class('/blog/success')).to eq(nil)
      end
    end
  end
end

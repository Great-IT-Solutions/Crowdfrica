feature 'Admin manages blog', js: true do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:post) { build(:blog_post) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario '#create a blog post', :aggregate_failures, :js do
    click_on 'Blog Posts'
    click_on 'New Blog Post'
    fill_in 'Title', with: ' '
    fill_in 'Summary', with: ' '
    fill_in 'Blog Image Link', with: ' '
    fill_in 'Author Bio', with: ' '
    click_on 'Create Blog post'
    expect(page).to have_content 'Could not create blog post'

    fill_in 'Title', with: post.title
    fill_in 'Summary', with: post.summary
    fill_in 'Blog Image Link', with: post.image_url
    fill_in_trix_editor 'body', with: 'Body'
    fill_in 'Author Bio', with: post.author_bio
    click_on 'Create Blog post'
    expect(page).to have_content 'Blog post created successfully'
  end

  scenario '#updates a blog post successfully', :aggregate_failures, :js do
    create_blog_post
    visit admin_user_root_path
    click_on 'Blog Posts'
    click_on 'Edit'
    fill_in 'Title', with: ' '
    fill_in 'Summary', with: ' '
    fill_in 'Author Bio', with: ' '
    click_on 'Update Blog post'
    expect(page).to have_content 'Could not update blog post'

    fill_in 'Title', with: 'Updated Blog title'
    fill_in 'Summary', with: 'Updated blog summary'
    click_on 'Update Blog post'
    expect(page).to have_content 'Blog post updated successfully'
  end

  scenario '#deletes a blog post successfully' do
    create_blog_post
    visit admin_user_root_path
    click_on 'Blog Posts'
    click_on 'Delete'
    page.accept_alert
    expect(page).to have_content 'Blog post deleted successfully'
  end

  private

  def create_blog_post
    post.save!
  end
end

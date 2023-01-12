feature 'Blog comments' do
  before do
    create(:blog_post)
  end

  it 'user creates and deletes comment', :aggregate_failures do
    sign_in_as_donor
    visit blog_posts_path
    click_on 'Read more', match: :first
    find('.comments').click
    fill_in 'comment_body', with: 'Comment on new blog'
    click_on 'Post'
    expect(page).to have_content 'Comments (1)'
    find('.comments').click
    click_on 'Delete'
    expect(page).to have_content 'Comments (0)'
  end
end

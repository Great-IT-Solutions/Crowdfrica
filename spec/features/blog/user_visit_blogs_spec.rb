feature 'User visit blogs' do
  before do
    create(:blog_post)
    create(:blog_post, tags: %w[health education])
    create(:blog_post, tags: %w[health fundraising])
    create(:blog_post, tags: %w[success fundraising])
    create(:blog_post, tags: %w[success education], created_at: 1.second.from_now)
  end

  it 'displays posts from all categories', :aggregate_failures do
    visit blog_posts_path
    BlogPost.all.each { |post| expect(page).to have_content post.title }
  end

  it 'displays only posts from health category', :aggregate_failures do
    visit blog_health_path
    expect_blog_posts_to_be_only(:health)
  end

  it 'displays only posts from education category', :aggregate_failures do
    visit blog_education_path
    expect_blog_posts_to_be_only(:education)
  end

  it 'displays only posts from fundraising category', :aggregate_failures do
    visit blog_fundraising_path
    expect_blog_posts_to_be_only(:fundraising)
  end

  it 'displays only posts from success stories category', :aggregate_failures do
    visit blog_success_path
    expect_blog_posts_to_be_only(:success)
  end

  it 'displays a particular blog details', :aggregate_failures do
    visit blog_posts_path
    latest_post = BlogPost.order(created_at: :desc).first
    click_on 'Read more', match: :first
    expect(page).to have_content(latest_post.title)
    expect(page).to have_content(latest_post.author.fullname)
  end

  def expect_blog_posts_to_be_only(tag)
    BlogPost.all.each { |post| check_blog_post_title(tag, post) }
  end

  def check_blog_post_title(tag, post)
    if post.tags&.include?(tag.to_s)
      expect(page).to have_content(post.title)
    else
      expect(page).not_to have_content(post.title)
    end
  end
end

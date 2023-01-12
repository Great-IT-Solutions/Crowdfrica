require 'koala'

feature 'Login using facebook', skip: true do
  before do
    @test_users_api = Koala::Facebook::TestUsers.new(app_id: ENV['FB_APP_ID'], secret: ENV['FB_SECRET_KEY'])
    @test_user = @test_users_api.create(false)
  end

  after do
    @test_users_api.delete(@test_user['id'])
  end

  scenario 'authenticates Successfully', js: true do
    visit root_path
    click_on 'Sign In'
    sleep(1)
    click_on 'Login with Facebook'
    fill_in 'email', with: @test_user['email']
    fill_in 'pass', with: @test_user['password']
    click_on 'loginbutton'
    sleep(1)
    page.find('html').send_keys(:escape) # ignore notifications block/allow alert
    find(:xpath, "//button[@name='__CONFIRM__']").click
    expect(page).to have_content('Successfully authenticated from Facebook account.')
  end
end

feature 'Admin login' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  scenario 'authenticates successfully', :aggregate_failures do
    visit new_admin_user_session_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: admin_user.password

    click_on 'Log in'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_current_path(admin_user_root_path)
  end

  scenario 'authentication fails', :aggregate_failures do
    visit new_admin_user_session_path
    fill_in 'Email', with: admin_user.email
    fill_in 'Password', with: 'invalid-password'

    click_on 'Log in'
    expect(page).to have_content 'Invalid Email or password.'
    expect(page).to have_current_path(new_admin_user_session_path)
  end

  scenario 'redirects to login when accessing protected paths' do
    [admin_user_root_path, new_admin_category_path, admin_championships_path, admin_championship_requests_path,
     admin_settings_path, admin_restricted_all_projects_path, admin_donations_path(p: 'stripe')].each do |path|
      visit path
      expect(page).to have_current_path new_admin_user_session_path
    end
  end
end

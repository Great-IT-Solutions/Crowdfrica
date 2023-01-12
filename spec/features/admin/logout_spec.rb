feature 'Admin logout' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  scenario 'Logs out successfully', :aggregate_failures do
    sign_in admin_user
    visit admin_user_root_path
    click_on 'Sign out'

    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_current_path(new_admin_user_session_path)
  end
end

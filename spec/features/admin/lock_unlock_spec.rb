feature 'Admin lock and unlock' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  scenario 'Admin is locked out after too many unsuccessful login attempts', :aggregate_failures do
    visit new_admin_user_session_path
    Devise.maximum_attempts.times do
      fill_in 'Email', with: admin_user.email
      fill_in 'Password', with: 'invalid-password'
      click_on 'Log in'
    end

    # devise is set to parnoid mode so no lock specific message
    expect(page).to have_content 'Invalid Email or password.'
    expect(admin_user.reload).to be_access_locked
  end

  scenario 'Admin unlocks account', :aggregate_failures do
    admin_user.lock_access!
    /href="(.*)"/ =~ ActionMailer::Base.deliveries.last.body.to_s
    visit Regexp.last_match[1]

    expect(page).to have_content 'Your account has been unlocked successfully. Please sign in to continue.'
  end
end

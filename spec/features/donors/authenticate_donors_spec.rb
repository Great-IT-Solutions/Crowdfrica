feature 'Authenticate donor' do
  scenario 'authenticates successfully', js: true do
    donor = create(:donor)

    visit root_path
    click_on 'Sign In'
    sleep(1)
    fill_in 'Email', with: donor.email
    fill_in 'Password', with: donor.password
    click_on 'Sign in'

    expect(page).to have_content donor.fullname
  end
end

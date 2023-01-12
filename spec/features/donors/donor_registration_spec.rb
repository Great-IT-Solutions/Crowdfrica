feature 'Donor Registration' do
  scenario 'Donor signs up successfully' do
    donor = build(:donor)

    visit root_path
    within('nav') { click_on 'Sign Up' }
    within('#signupModal') do
      fill_in 'Fullname', with: donor.fullname
      fill_in 'Email', with: donor.email
      fill_in 'Password', with: donor.password
      fill_in 'Password confirmation', with: donor.password
      click_on 'Sign up'
    end

    expect(page).to have_content donor.fullname
  end

  scenario 'Donor updates fullname' do
    donor = create(:donor)
    login_as donor
    visit root_path
    find('.dropdown-toggle .drop').click
    click_on 'Settings'
    fill_in 'Fullname', with: 'Updated Name'
    fill_in 'Current password', with: donor.password
    click_on 'UPDATE'

    expect(page).to have_content 'Your account has been updated successfully.'
  end

  scenario 'Donor updates password' do
    donor = create(:donor)
    login_as donor
    visit root_path
    find('.dropdown-toggle .drop').click
    click_on 'Settings'
    fill_in 'Password', with: 'NewPassword'
    fill_in 'Password confirmation', with: 'NewPassword'
    fill_in 'Current password', with: donor.password
    click_on 'UPDATE'
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
  end

  scenario 'Donor cannot use the default devise signup page' do
    visit new_donor_registration_path

    expect(page).to have_content 'Ooops seems like you are lost!!'
  end
end

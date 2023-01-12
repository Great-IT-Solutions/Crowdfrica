feature 'Settings' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  scenario 'View, create and update settings', :aggregate_failures do
    sign_in admin_user
    visit admin_user_root_path
    click_on 'Settings'

    fill_in 'GHS Rate', with: '1.0'
    fill_in 'NGN Rate', with: '2.0'
    fill_in 'KES Rate', with: '3.0'
    click_on 'Update Exchange Rate'

    expect(page).to have_content 'rate created successfully'
    expect(page).to have_field 'GHS Rate', with: '1.0'
    expect(page).to have_field 'NGN Rate', with: '2.0'
    expect(page).to have_field 'KES Rate', with: '3.0'

    fill_in 'GHS Rate', with: '3.0'
    fill_in 'NGN Rate', with: '6.0'
    fill_in 'KES Rate', with: '9.0'
    click_on 'Update Exchange Rate'

    expect(page).to have_content 'rate updated successfully'
    expect(page).to have_field 'GHS Rate', with: '3.0'
    expect(page).to have_field 'NGN Rate', with: '6.0'
    expect(page).to have_field 'KES Rate', with: '9.0'
  end
end

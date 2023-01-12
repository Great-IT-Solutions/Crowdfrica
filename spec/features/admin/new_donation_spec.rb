feature 'New Donation' do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let(:campaign) { FactoryBot.create(:campaign) }

  scenario 'Go to new donation', :aggregate_failures do
    sign_in admin_user
    visit admin_user_root_path
    click_on 'New Project'

    fill_in 'Project ID', with: 'invalid-id'
    click_on 'New Donation'
    expect(page).to have_content 'Project Not Found !'
    expect(page).to have_current_path admin_restricted_new_project_path

    fill_in 'Project ID', with: campaign.id
    click_on 'New Donation'

    expect(page).to have_current_path new_donation_path(campaign)
  end
end

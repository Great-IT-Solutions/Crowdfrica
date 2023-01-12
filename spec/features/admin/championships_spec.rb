feature 'Manages championships' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Create a championship', :aggregate_failures do
    campaign = create(:campaign)
    donor = create(:donor)
    click_on 'Championships'
    expect(page).to have_content 'There are no Championships'

    click_on 'Create A Championship'
    fill_in 'Campaign id', with: campaign.id
    fill_in 'Donor id', with: donor.id
    select 'Carer', from: 'Relationship to beneficiary'
    fill_in 'Please write a message which will persuade people to donate', with: 'Hello'
    click_on 'Create Championship'

    expect(page).to have_content 'A New Championship Was Created'
  end

  scenario 'Edit a championship' do
    create(:championship)
    click_on 'Championships'
    click_on 'Edit Championship'
    fill_in 'Relationship to beneficiary', with: 'Carer'
    click_on 'Update Championship'

    expect(page).to have_content 'Your changes were saved'
  end

  scenario 'Delete a championship' do
    create(:championship)
    click_on 'Championships'
    click_on 'Delete Championship'

    expect(page).to have_content 'The Championship has been removed.'
  end
end

feature 'User visits My Profile page' do
  let(:campaign_name) { 'This is a great campaign' }
  let(:campaign) { create(:campaign, campaign_name: campaign_name) }
  let(:champion_campaign_name) { 'This is a campaign backed by a champion' }
  let(:champion_campaign) { create(:campaign, campaign_name: champion_campaign_name) }
  let(:donor) { create(:donor) }
  let!(:championship) { create(:championship, champion: donor, campaign: champion_campaign) }

  before do
    sign_in_as_donor(donor)
    create(:donation, donor: donor, project: campaign.project)
  end

  scenario 'User sees the campaigns they have funded and championed', :aggregate_failures do
    visit root_path
    click_link 'My Profile'

    expect(page).to have_current_path donor_path(donor)
    expect(page).to have_text "Here are all the projects #{donor.fullname} has funded or co-funded"
    expect(page).to have_text campaign_name
    expect(page).to have_text "Here are all the projects #{donor.fullname} has Championed"
    expect(page).to have_text champion_campaign_name
  end

  scenario 'User edits and deletes their championship', :aggregate_failures do
    visit root_path
    click_link 'My Profile'
    click_link 'Edit Championship'

    expect(page).to have_current_path edit_championship_path(championship)
    expect(page).to have_field 'Relationship to beneficiary', with: 'Supporter'
    expect(page).to have_field 'message', with: 'Hello'

    fill_in 'Relationship to beneficiary', with: 'Relative'
    fill_in 'message', with: 'My championship message'
    click_button 'Update Championship'

    expect(page).to have_text 'Your changes were saved'
    expect(page).to have_current_path donor_path(donor)
    expect(page).to have_text 'My championship message'

    click_link 'Withdraw Championship'
    expect(page).to have_text 'The Championship has been removed'
    expect(page).to have_current_path donor_path(donor)
    expect(page).not_to have_text 'My championship message'
  end

  scenario "User cannot edit another user's championship", :aggregate_failures do
    championship = create(:championship)
    expect { visit edit_championship_path(championship) }.to raise_error(ActiveRecord::RecordNotFound)
  end
end

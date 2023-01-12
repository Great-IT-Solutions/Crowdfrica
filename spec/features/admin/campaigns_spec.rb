feature 'Manages campaigns' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Create a campaign' do
    create(:project)
    campaign = build(:campaign)
    click_on 'Projects'
    click_on 'create campaign from here'
    fill_in 'campaign_campaign_name', with: campaign.campaign_name
    fill_in 'campaign_campaign_headline', with: campaign.campaign_headline
    fill_in 'campaign_campaign_image_url', with: campaign.campaign_image_url
    check 'campaign_published'
    click_on 'Create Campaign'

    expect(page).to have_content 'Campaign created succesfully'
  end

  scenario 'Edit a campaign' do
    create(:campaign)
    click_on 'Projects'
    click_on 'Edit Campaign'
    fill_in 'campaign_campaign_name', with: 'Updated Campaign Name'
    click_on 'Update Campaign'

    expect(page).to have_content 'Campaign updated succesfully'
  end

  scenario 'Preview a campaign' do
    campaign = create(:campaign)
    click_on 'Projects'
    click_on 'Preview Campaign'

    expect(page).to have_content campaign.campaign_name
  end
end

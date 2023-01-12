feature 'User visits a Campaign page' do
  scenario 'User views a Campaign page', :aggregate_failures do
    campaign = create(:campaign)
    donation = create(:donation, project: campaign.project, amount: 33.3567)
    create(:donation, project: campaign.project, anonymous: true, amount: 25)
    visit campaign_path(campaign)

    expect(page).to have_content campaign.project.project_name
    expect(page).to have_highlighted_menu('Campaigns')
    expect(page).to have_xpath("//a[@title=\"#{donation.donor.fullname} - $33.36\"]")
    expect(page).to have_xpath('//img[@title="Anonymous donor - $25.00"]')
  end
end

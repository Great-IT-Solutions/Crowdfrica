feature 'User visits Campaigns page' do
  scenario 'User navigates to Campaigns and sees first 12 campaigns', :aggregate_failures do
    create_all_types_of_campaigns(5)
    visit root_path
    click_on 'campaigns-nav'
    expect(page).to have_selector('h1', exact_text: 'Campaigns')
    expect(page).to have_highlighted_menu('Campaigns')
    expect(page).to have_css('.campaign-card-small', count: 12)
  end
end

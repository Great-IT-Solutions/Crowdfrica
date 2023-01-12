feature 'User visits homepage' do
  scenario '#can see the heading' do
    visit root_path
    expect(page).to have_content('Meet people and life-changing teachers in need of your support')
  end

  scenario '#can see 9 featured campaigns' do
    create_all_types_of_campaigns(3)
    visit root_path
    expect(page).to have_css('.campaign-card-small', count: 18)
  end
end

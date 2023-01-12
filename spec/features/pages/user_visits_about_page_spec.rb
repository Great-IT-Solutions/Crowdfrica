feature 'User visits About page' do
  scenario 'User visits About us page', :aggregate_failures do
    visit root_path
    click_on 'about-us-nav'
    expect(page).to have_highlighted_menu('About Us')
    expect(page).to have_content 'We are connecting people to finance access to healthcare '\
                                 'and quality education and entrepreneurship in Africa'
    expect(page).to have_content 'Individual commitment to a group effort - that is what makes a team work, '\
                                 'a company work, a society work, a civilization work'
    expect(page).to have_content 'One People. Healthy. Educated'
  end

  scenario 'User visits Our Team page', :js do
    visit about_path
    click_on 'Our Team'
    expect(page).to have_link 'Randy Caiquo', href: 'https://www.linkedin.com/in/rcaiquo/'
  end

  scenario 'User visits Partners page', :js do
    visit about_path
    click_on 'Partners'
    expect(page).to have_content 'Crowdfrica in partnership with Strategic Impact Advisors'
  end
end

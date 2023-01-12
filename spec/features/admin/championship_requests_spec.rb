feature 'Manages championship requests' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Edit a championship request' do
    create(:championship_request)
    click_on 'Championship Requests'
    click_on 'Edit Request'
    fill_in 'Why do you want to champion this campaign', with: 'It will make a difference'
    click_on 'Update Championship request'

    expect(page).to have_content 'The Championship Request has been updated'
  end

  scenario 'Approve a championship request' do
    create(:championship_request)
    click_on 'Championship Requests'
    click_on 'Approve Request'

    expect(page).to have_content 'A New Championship Was Created'
  end
end

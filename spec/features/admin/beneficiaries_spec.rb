feature 'Manage beneficiaries' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Create new beneficiary', :aggregate_failures do
    create_categories
    beneficiary = build(:beneficiary)
    click_on 'New Project'
    click_on 'Create project beneficiary'

    fill_in 'Beneficiary name', with: beneficiary.beneficiary_name
    select 'Ghana', from: 'beneficiary_country'
    select 'Patient', from: 'beneficiary_btype'
    click_on 'Create Beneficiary'
    expect(page).to have_content beneficiary.beneficiary_name
  end

  scenario 'Edit a beneficiary' do
    create(:project)
    click_on 'Projects'
    click_on 'Edit Beneficiary'

    fill_in 'beneficiary_beneficiary_name', with: 'Updated Beneficiary Name'
    click_on 'Update Beneficiary'
    expect(page).to have_content 'Beneficiary has been successfully updated'
  end
end

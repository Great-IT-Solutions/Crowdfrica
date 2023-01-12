feature 'Admin manages Project' do
  let(:admin_user) { FactoryBot.create(:admin_user) }
  let!(:project) { create(:project) }

  before do
    sign_in admin_user
    visit admin_user_root_path
  end

  scenario 'Create a project', :aggregate_failures, :js do
    create_categories
    click_on 'New Project'
    click_on 'Create project beneficiary'
    fill_in 'Beneficiary name', with: project.beneficiary.beneficiary_name
    select 'Ghana', from: 'beneficiary_country'
    select 'Patient', from: 'beneficiary_btype'
    click_on 'Create Beneficiary'
    fill_in 'project_project_name', with: project.project_name
    fill_in_trix_editor 'project_project_description', with: 'Hello'
    click_on 'Create Project'

    expect(page).to have_content "Could not create #{project.project_name}"

    choose('Patients')
    fill_in 'project_medical_cost', with: 10
    fill_in 'project_processing', with: 10
    fill_in 'project_operational_costs', with: 10
    fill_in 'project_cost', with: 30
    click_on 'Create Project'

    expect(page).to have_content "#{project.beneficiary.beneficiary_name}'s project has been successfully created"
  end

  scenario 'Updates a project', :aggregate_failures do
    create_categories
    click_on 'Projects'
    click_on 'Revisit Project'
    fill_in 'project_project_name', with: ''
    click_on 'Update Project'

    expect(page).to have_content 'Could not update'

    fill_in 'project_project_name', with: 'Update project title'
    click_on 'Update Project'

    expect(page).to have_content 'Project has been successfully updated'
  end

  scenario 'Delete a project', js: true do
    click_on 'Projects'
    click_on 'Delete Project'
    page.accept_alert

    expect(page).to have_content 'Successfully deleted'
  end

  scenario 'View project donations', :aggregate_failures do
    donation = create(:donation, project: project)
    click_on project.project_name

    expect(page).to have_content 'Listing Donors'
    expect(page).to have_table_columns ['*', 'Donor', 'Email']
    expect(page).to have_table_rows ['*', donation.donor.fullname.upcase, donation.donor.email]
  end
end

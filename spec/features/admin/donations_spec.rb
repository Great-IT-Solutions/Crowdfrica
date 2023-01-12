feature 'View donations' do
  let(:admin_user) { FactoryBot.create(:admin_user) }

  scenario 'View ussd', :aggregate_failures do
    emergent = FactoryBot.create(:emergent_donation, amount: 25, ghs_amount: 125)
    sign_in admin_user
    visit admin_user_root_path

    click_on 'USSD Donations'
    expect(page).to have_table_columns ['Project Name', 'Date', 'Donation ($)', 'Donation (GHS)', 'Anonymous', 'Donor',
                                        'Mobile', 'Email']
    expect(page).to have_table_rows(
      [emergent.project.project_name, '*', '25.00', '125.00', 'false', emergent.donor.fullname,
       emergent.donor.mobile_number, emergent.donor.email]
    )
  end

  scenario 'View paypal and squareup donations', :aggregate_failures do
    paypal = FactoryBot.create(:paypal_donation, amount: 30)
    squareup = FactoryBot.create(:squareup_donation, amount: 35)
    sign_in admin_user
    visit admin_user_root_path
    click_on 'Paypal Donations'

    expect(page).to have_table_columns(
      ['Project Name', 'Date ', 'Donation ($)', 'Tip($)', 'Anonymous', 'Donor', 'Email']
    )
    expect(page).to have_table_rows(
      [paypal.project.project_name, '*', '30.00', '0.00', false, paypal.donor.fullname, paypal.donor.email]
    )

    click_on 'Squareup Donations'
    expect(page).to have_table_columns(
      ['Project Name', 'Date ', 'Donation ($)', 'Anonymous', 'Donor', 'Email', 'Tip Amount ($)', 'Tip Amount (GHS)']
    )
    expect(page).to have_table_rows([squareup.project.project_name, '*', '35.00', false, squareup.donor.fullname,
                                     squareup.donor.email, '0.00', '0.00'])
  end
end

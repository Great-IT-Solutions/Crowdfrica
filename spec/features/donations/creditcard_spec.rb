feature 'Test Master card using PIN authentication' do
  let(:campaign) { create(:campaign) }
  let(:donor) { build(:donor) }

  scenario 'Registered User', :js, :aggregate_failures do
    donor = sign_in_as_donor
    visit campaign_path(campaign)
    fill_in 'amount', with: 3
    click_button 'Donate Now'

    expect(page).to have_current_path new_donation_path(campaign, amount: 3)
    choose 'Credit card'
    expect(page).to have_field 'squareup_amount', with: 3
    expect(page).to have_field 'No tip', checked: true
    expect(page).to have_field '$ 0.15'
    expect(page).to have_field '$ 0.3'
    expect(page).to have_field '$ 0.45'
    expect(page).to have_field 'Custom tip amount'

    choose '$ 0.15'

    fill_in_credit_card_details
    click_on 'Continue'
    expect(page).to have_content 'your donation has been received succesfully'
    donation = donor.donations.first
    expect(donation.amount).to eq 3
    expect(donation.tip).to eq 0.15
  end

  scenario 'Unegistered User', :js, :aggregate_failures do
    visit campaign_path(campaign)
    fill_in 'amount', with: 3
    click_button 'Donate Now'

    expect(page).to have_current_path new_donation_path(campaign, amount: 3)
    choose 'Credit card'
    expect(page).to have_field 'squareup_amount', with: 3
    expect(page).to have_field 'No tip', checked: true
    expect(page).to have_field '$ 0.15'
    expect(page).to have_field '$ 0.3'
    expect(page).to have_field '$ 0.45'
    expect(page).to have_field 'Custom tip amount'

    choose 'Custom tip amount'
    fill_in 'squareup_custom_tip_amount', with: 4

    fill_in_via_placeholder 'Full Name', with: donor.fullname
    fill_in_via_placeholder 'Email', with: donor.email
    fill_in_via_placeholder 'Password', with: donor.password
    fill_in_credit_card_details
    click_on 'Continue'

    expect(page).to have_content 'your donation has been received succesfully'
    new_donor = Donor.find_by email: donor.email
    expect(new_donor).not_to be_nil
    donation = new_donor.donations.first
    expect(donation.amount).to eq 3
    expect(donation.tip).to eq 4
  end
end

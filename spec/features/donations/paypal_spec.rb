feature 'Donation to campaign with paypal' do
  let(:campaign) { create(:campaign) }
  let(:paypal_email) { ENV['PAYPAL_TEST_EMAIL'] }
  let(:paypal_password) { ENV['PAYPAL_TEST_PASSWORD'] }

  scenario 'Registered User', :js, :aggregate_failures do
    donor = sign_in_as_donor
    visit campaign_path(campaign)
    fill_in 'amount', with: 3
    click_button 'Donate Now'

    expect(page).to have_current_path new_donation_path(campaign, amount: 3)
    choose 'PayPal'
    expect(page).to have_field 'paypal_amount', with: 3
    expect(page).to have_field 'No tip', checked: true
    expect(page).to have_field '$ 0.15'
    expect(page).to have_field '$ 0.3'
    expect(page).to have_field '$ 0.45'
    expect(page).to have_field 'Custom tip amount'

    choose '$ 0.15'

    within_frame(0) { find('.paypal-button-label-container').click }
    switch_to_window windows.last

    fill_in 'login_email', with: paypal_email
    click_button 'Next'

    # for some reason, the login email screen sometimes displays again
    unless has_no_field?('login_email') # not using has_field? since we may need to wait for field to disappear
      fill_in 'login_email', with: paypal_email
      click_button 'Next'
    end

    fill_in 'login_password', with: paypal_password
    click_button 'Log In'
    click_button 'acceptAllButton' if has_button?('acceptAllButton')
    scroll_to :bottom
    # keep clicking 'Pay Now' until it dismisses the window. Not sure why this is necessary
    # but perhaps something to do with slow js loading?!
    while windows.second.present?
      click_button 'Pay Now'
      sleep 1
    end

    switch_to_window windows.first

    sleep 7 # required since we are calling the Paypal API
    expect(page).to have_current_path thank_you_campaign_path(campaign)
    expect(page).to have_content 'Thank you for your donation.'
    donation = donor.donations.first
    expect(donation.amount).to eq 3
    expect(donation.tip).to eq 0.15
  end

  scenario 'Unregistered User', :js, :aggregate_failures do
    visit campaign_path(campaign)
    fill_in 'amount', with: 3
    click_button 'Donate Now'

    expect(page).to have_current_path new_donation_path(campaign, amount: 3)
    choose 'PayPal'
    expect(page).to have_field 'paypal_amount', with: 3
    expect(page).to have_field 'No tip', checked: true
    expect(page).to have_field '$ 0.15'
    expect(page).to have_field '$ 0.3'
    expect(page).to have_field '$ 0.45'
    expect(page).to have_field 'Custom tip amount'

    choose 'Custom tip amount'
    fill_in 'paypal_custom_tip_amount', with: 4

    within_frame(0) { find('.paypal-button-label-container').click }
    switch_to_window windows.last

    fill_in 'login_email', with: paypal_email
    click_button 'Next'

    # for some reason, the login email screen sometimes displays again
    unless has_no_field?('login_email') # not using has_field? since we may need to wait for field to disappear
      fill_in 'login_email', with: paypal_email
      click_button 'Next'
    end

    fill_in 'login_password', with: paypal_password
    click_button 'Log In'
    click_button 'acceptAllButton' if has_button?('acceptAllButton')
    scroll_to :bottom
    # keep clicking 'Pay Now' until it dismisses the window. Not sure why this is necessary
    # but perhaps something to do with slow js loading?!
    while windows.second.present?
      click_button 'Pay Now'
      sleep 1
    end

    switch_to_window windows.first

    sleep 7 # required since we are calling the Paypal API
    expect(page).to have_current_path(thank_you_campaign_path(campaign))
    expect(page).to have_content 'Thank you for your donation.'
    donor = Donor.find_by email: paypal_email
    expect(donor).not_to be_nil
    donation = donor.donations.first
    expect(donation.amount).to eq 3
    expect(donation.tip).to eq 4
  end
end

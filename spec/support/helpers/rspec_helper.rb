module Helpers
  module GeneralHelper
    def alert_present?
      session.driver.browser.switch_to.alert
      # puts 'Alert present! Switched to alert.'
      true
    rescue StandardError
      # puts 'No alert present.'
      false
    end

    def fill_in_via_placeholder(placeholder, with:)
      find(:xpath, "//input[@placeholder='#{placeholder}']").set(with)
    end

    # see https://medium.com/eighty-twenty/testing-the-trix-editor-with-capybara-and-minitest-158f895ad15f
    def fill_in_trix_editor(id, with:)
      find(:xpath, "//trix-editor[@id='#{id}']").click.set(with)
    end
  end

  module CampaignHelper
    def create_all_types_of_campaigns(count)
      FactoryBot.create_list(:campaign, count, :patient)
      FactoryBot.create_list(:campaign, count, :entrepreneur)
      FactoryBot.create_list(:campaign, count, :classroom_supplies)
    end
  end

  module DonationHelper
    def fill_in_credit_card_details # rubocop:disable Metrics/MethodLength
      within_frame('sq-card-number') do
        fill_in_via_placeholder 'Card Number', with: '4111 1111 1111 1111'
      end
      within_frame('sq-expiration-date') do
        fill_in_via_placeholder 'MM/YY', with: '09/22'
      end
      within_frame('sq-cvv') do
        fill_in_via_placeholder 'CVV', with: '564'
      end
      within_frame('sq-postal-code') do
        fill_in_via_placeholder 'Postal', with: '10437'
      end
    end
  end

  module AdminHelper
    def create_categories
      FactoryBot.create(:category, :patient)
      FactoryBot.create(:category, :health_insurance)
      FactoryBot.create(:category, :classroom_supplies)
    end

    def sign_in_as_donor(donor = nil)
      donor ||= FactoryBot.create(:donor)
      login_as donor
      donor
    end
  end
end

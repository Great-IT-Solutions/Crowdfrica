class FounderStoryMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.founder_story_mailer.founder_story.subject
  #
  def founder_story(donor)
    @donor = donor
    @donor_name = @donor.fullname

    mail to: @donor.email
  end
end

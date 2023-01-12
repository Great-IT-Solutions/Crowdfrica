class PaymentMailer < ApplicationMailer
  # Subject can be set in your I18n file at config/locales/en.yml
  # with the following lookup:
  #
  #   en.payment_mailer.new_payment.subject
  #
  def new_payment(donation, donor)
    @donation = donation
    @beneficiary = Project.find(@donation.project_id)
    @beneficiary_id = Beneficiary.find(@beneficiary.beneficiary_id)
    @beneficiary_name = @beneficiary_id.beneficiary_name
    # this was to acquire the beneficiary name

    @project_name = @beneficiary.project_name
    @campaign = Campaign.friendly.find_by(project_id: @donation.project_id)
    @campaign_id = @campaign.friendly_id
    # to acquire the project name
    @donor = donor

    mail to: @donor.email,
         subject: 'Grateful'
  end
end

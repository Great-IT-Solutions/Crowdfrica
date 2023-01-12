class EmergentPayment < ApplicationService
  attr_reader :campaign, :attributes, :payment_reference, :mobile_number, :amount_str, :amount, :fullname

  def initialize(campaign, attributes)
    @campaign = campaign
    @attributes = attributes
    @payment_reference = attributes[:payment_reference]
    @mobile_number = attributes[:mobile_number]
    @amount_str = attributes[:amount]
    @fullname = attributes[:fullname]
    validate_data_types!
    @amount = Float(amount_str) # params are always string
  end

  def call!
    us_dollars = Exrate.convert_to_usd(amount)
    donor = find_and_update_or_create_donor!
    campaign.project.donations.create!(amount: us_dollars, ghs_amount: amount, anonymous: false, via: 'emergent',
                                       order_id: payment_reference, donor: donor)
  rescue StandardError => e
    handle_error(e)
  end

  private

  def validate_data_types!
    raise EmergentException, 'amount is not a number' unless numeric?(amount_str)
  end

  # see https://mentalized.net/journal/2011/04/14/ruby-how-to-check-if-a-string-is-numeric/
  def numeric?(number)
    !Float(number).nil? rescue false # rubocop:disable Style/RescueModifier
  end

  def find_and_update_or_create_donor!
    donor = Donor.find_by(mobile_number: mobile_number)
    donor.update!(fullname: fullname) if donor && fullname.present?
    return donor if donor

    Donor.create!(mobile_number: mobile_number, phone: mobile_number, fullname: fullname.presence || mobile_number,
                  password: SecureRandom.urlsafe_base64(20), email: "emergent.#{payment_reference}@crowdfrica.org")
  end

  def handle_error(exception)
    # avoid sending sensitive data to Airbrake
    keys = attributes.keys.filter { |attr| %w[emergent app_key].exclude?(attr) }
    Airbrake.notify(exception, attributes.slice(*keys))
    raise EmergentException, exception.message
  end
end

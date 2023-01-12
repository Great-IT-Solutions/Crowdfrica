class Donation < ApplicationRecord
  include HTTParty

  # Association
  # donor, projects and donation
  belongs_to :project
  has_many   :interpay_payment_logs
  has_many   :rave_payment_logs
  has_many   :paypal_payment_logs
  belongs_to :donor

  # Validation
  validates :order_id, uniqueness: { scope: :via }, allow_nil: true

  def process_payment_for_registered(_donor, payment_params = {})
    Stripe::Charge.create(
      amount: amount_to_c(payment_params[:donation][:amount]),
      currency: 'usd',
      card: payment_params[:stripe_payment][:StripeToken]
    )
  end

  def process_payment_for_unregistered(_donor, payment_params = {})
    Stripe::Charge.create(
      amount: amount_to_c(payment_params[:donation][:amount]),
      currency: 'usd',
      card: payment_params[:stripe_payment][:StripeToken]
    )
  end

  def self.process_interpay_payment(parameters)
    HTTParty.post(
      ENV['BASE_URL'] + 'interapi/ProcessPayment',
      body: parameters,
      headers: {
        'Content-Type' => 'application/json'
      }
    )
  end

  def amount_to_c(amount)
    amount_in_dollars = amount
    @amount_in_cents = (amount_in_dollars.to_f * 100).to_i
  end

  def self.process_squareup_payment(parameters, donor)
    donor.set_square_account unless donor.has_a_square_customer_account?

    client = Square::Client.new(access_token: ENV['SQUAREUP_ACCESS_TOKEN'], environment: ENV['SQUAREUP_ENV'])
    payments_api = client.payments
    idempotency_key = SecureRandom.uuid

    body = {}
    body[:source_id] = parameters[:nounce]
    body[:idempotency_key] = idempotency_key
    body[:amount_money] = {}
    body[:amount_money][:amount] = parameters[:amount].to_f * 100
    body[:amount_money][:currency] = parameters[:currency]
    body[:customer_id] = donor.square_customer_id
    payments_api.create_payment(body: body)
  end

  def date
    created_at
  end

  def self.to_csv
    require 'csv'
    attributes = %w{id Project Date Donation($) Donation(GHS) Anonymous Donor Mobile Email}
    CSV.generate(headers: true) do |csv|
      csv << attributes
      all.each do |donation|
        date = donation.date.to_time.strftime('%e %b %Y at %l:%M %p')
        csv << [donation.id, donation.project.project_name, date, donation.amount.to_f, donation.ghs_amount.to_f, donation.anonymous, donation.donor.fullname, donation.donor.mobile_number, donation.donor.email]
      end
    end
  end

end

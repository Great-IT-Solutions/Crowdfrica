class Donor < ApplicationRecord
  extend FriendlyId
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,   :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  devise :omniauthable, omniauth_providers: [:facebook]

  # Use friendly_id
  friendly_id :fullname, use: :slugged

  # Enum for gender
  enum gender: { male: 0, female: 1 }

  # Associations
  has_many :donations, dependent: :destroy
  has_many :projects, through: :donations
  has_many :comments, as: :commenter, dependent: :destroy
  has_one :championship, dependent: :destroy, foreign_key: 'champion_id'
  has_many :championship_requests, dependent: :destroy, foreign_key: 'champion_id'

  validates :phone, length: { minimum: 5, maximum: 15, allow_blank: true }
  # mobile number is not set by the user but set automatically when a USSD donation is made
  validates :mobile_number, uniqueness: { allow_nil: true }
  validates :fullname, presence: true
  validates :email, uniqueness: { case_sensitive: true }

  # donor avatar
  def profile_image?
    !image.nil?
  end

  def initials
    fullname[0].upcase
  end

  def first_name
    fullname.split(' ')[0]
  end

  def new_donation(params, charge, flw_ref)
    donation = donations.new(
      amount: params[:rave][:amount],
      project_id: params[:rave][:project_id],
      donor_id: id,
      via: 'rave payment',
      flw_ref: flw_ref,
      anonymous: params[:rave][:anonymous],
      tip: params[:rave][:tip]
    )
    donation.rave_payment_logs.create(payment_log: charge) if donation.save
  end

  def is_authenticated_from_facebook?
    provider == 'facebook'
  end

  def self.new_with_session(params, session)
    super.tap do |user|
      if data = session['devise.facebook_data'] && session['devise.facebook_data']['extra']['raw_info']
        user.email = data['email'] if user.email.blank?
      end
    end
  end

  def new_squareup_donation(params)
    donation = donations.new(
      amount: params[:amount],
      project_id: params[:project_id],
      donor_id: id,
      via: 'squareup payment',
      # flw_ref: flw_ref,
      anonymous: params[:anonymous],
      tip: params[:tip]
    )
    donation.save
    donation
    # donation.squareup_payment_logs.create(payment_log: charge) if donation.save
  end

  def self.from_omniauth(auth)
    where(email: auth.info.email).first_or_create do |user|
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
      user.fullname = auth.info.name
      user.image = auth.info.image
    end
  end

  def set_square_account
    return if has_a_square_customer_account?

    client = Square::Client.new(access_token: ENV['SQUAREUP_ACCESS_TOKEN'], environment: ENV['SQUAREUP_ENV'])
    idempotency_key = SecureRandom.uuid
    body = {}
    body[:given_name] = fullname
    body[:email_address] = email
    body[:idempotency_key] = idempotency_key

    customers_api = customers_api = client.customers
    result = customers_api.create_customer(body: body)

    if result.success?
      update_attribute(:square_customer_id, result.data.customer[:id])
      toggle!(:has_a_square_customer_account)
    end
  end
end

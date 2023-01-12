class DonationsController < ApplicationController
  require_relative '../../lib/paypal/paypal_client'

  include PayPalCheckoutSdk::Orders
  include DonorsHelper

  before_action :set_campaign
  skip_before_action :verify_authenticity_token, only: %i[paypal_payment gift_card_payment]

  def new; end

  def paypal_payment

    result = get_order(params[:orderID])
    donor = current_donor

    unless donor_is_registered?
      donor = Donor.find_by_email(params[:email])
      if donor.blank?
        token = SecureRandom.base64(15)
        donor = Donor.new(
          fullname: params[:fullname],
          email: params[:email],
          password: token,
          gender: rand(0..1),
          country: 'xxxxxx',
          slug: params[:fullname].downcase.concat(rand.to_s[1..7]).parameterize,
          color: color_gen
        )
       donor_status = donor.save(validate: false)

       Rails.logger.info "debuging ---------Donor INfo-----------------"
       Rails.logger.info  donor.inspect 
       Rails.logger.info "debuging -----------------1800---------"


        Rails.logger.info "debuging --------------Donor status------------"
        Rails.logger.info donor_status  
        Rails.logger.info "debuging -----------------1800---------"

      end
    end

    donation = donor.donations.build(
      amount: result.purchase_units[0].amount.value.to_f - params[:tip_amount].to_f,
      project_id: @campaign.project_id,
      tip: params[:tip_amount].to_f 
    )
  
    Rails.logger.info "debuging -----------Donation Info---------------"
    Rails.logger.info donation.inspect 
    Rails.logger.info "debuging ----------------/-1800---------"

   
   if donation.save
    paypal_record(donation)

    PaymentMailer.new_payment(donation, donor).deliver_later
    FounderStoryMailer.founder_story(donor).deliver_later if donor.donations.one?

    flash[:notice] = "Thank you #{donor.fullname}, your donation has been received successfully"
    user_redirect_path = thank_you_campaign_path(params[:campaign_id])
   else
    Rails.logger.info "debuging ----------Donation saving Failed---------"
    Rails.logger.info "DONATION ERRORS: #{donation.errors.full_messages}"
    flash[:alert] = "Sorry, Donation coudn't go through, please try again."
    user_redirect_path = campaign_path(params[:campaign_id])
   end

   render json: {redirect_url: user_redirect_path}
  end

  # Gift card donation

  def gift_card_payment
    conn = Faraday.new(url: 'https://api.giftup.app/') do |faraday|
      faraday.request :url_encoded # form-encode POST params
      faraday.response :logger # log requests to STDOUT
      faraday.adapter Faraday.default_adapter # make requests with Net::HTTP
    end

    response = conn.post do |req|
      req.url "/gift-cards/#{params[:giftcard_donation][:giftcode]}/redeem"
      req.headers['Content-Type'] = 'application/json'
      req.headers['x-giftup-testmode'] = 'false'
      req.headers['Authorization'] = ENV['GIFT_UP_ID']
      req.body = "{ 'amount': #{params[:giftcard_donation][:amount]} }"
    end

    if response.status == 200
      donor = current_donor

      unless donor_is_registered?
        donor = Donor.find_by(email: params[:giftcard_donation][:email])
        if donor.blank?
          token = SecureRandom.base64(15)
          dummy_phone = SecureRandom.base64(15)
          donor = Donor.new(
            fullname: params[:giftcard_donation][:fullname],
            email: params[:giftcard_donation][:email],
            password: token,
            phone: dummy_phone,
            gender: rand(0..1),
            country: 'xxxxxx',
            slug: (params[:giftcard_donation][:fullname]).downcase.concat(rand.to_s[1..7]).parameterize,
            color: color_gen
          )
          # we save the new unregistered donor into our db
          donor.save(validate: false)
        end
      end

      donation = donor.donations.build(
        amount: params[:giftcard_donation][:amount],
        project_id: @campaign.project_id
      )

      redirect_to thank_you_campaign_path(@campaign) if donation.save
    else
      flash[:alert] = 'There was an issue processing the payment. Please check the details you entered and try again'
      redirect_back fallback_location: root_path
    end
  end

  def squareup_payment
    if donor_is_registered?
      donor = current_donor
    else
      # Search for unregistered_donor first
      existing_unregistered_donor = Donor.find_by(email: params[:squareup][:email])
      # if we find you
      if existing_unregistered_donor
        donor = existing_unregistered_donor
      else
        # we create a new unregistered_donor if that donor does not already exist
        token = SecureRandom.base64(15)
        new_unregistered_donor = Donor.new(
          fullname: params[:squareup][:firstname],
          email: params[:squareup][:email],
          password: token, gender: rand(0..1),
          country: 'Ghana',
          slug: (params[:squareup][:firstname]).downcase.concat(rand.to_s[1..7]).parameterize,
          color: color_gen,
          phone: (100_000..999_999).to_a.sample
        )
        # we save the new unregistered donor into our db
        new_unregistered_donor.save(validate: false)
        donor = new_unregistered_donor
      end
    end

    squareup_response = Donation.process_squareup_payment(
      {
        nounce: params[:squareup][:nounce],
        amount: params[:squareup][:amount].to_f + params[:squareup][:tip].to_f,
        currency: 'USD'
      },
      donor
    )

    if squareup_response.success?
      donation = donor.new_squareup_donation(squareup_donation_params.merge(project_id: @campaign.project_id))

      redirect_to campaigns_path, notice: "Thank you #{donor.fullname}, your donation has been received succesfully."

      PaymentMailer.new_payment(donation, donor).deliver_now
      FounderStoryMailer.founder_story(donor).deliver_now if donor.donations.one?
    else
      errors = squareup_response.errors.map { |e| e[:detail] }.to_sentence
      redirect_to campaigns_path, alert: "We are sorry, your donation could not be processed due to errors: #{errors}"
    end
  end

  private

  def squareup_donation_params
    params.require(:squareup).permit(:nounce, :anonymous, :via, :firstname, :email, :amount, :tip, :country)
  end

  def paypal_record(donation)
    PaypalPaymentLog.create(donation_id: donation.id)
  end

  def get_order(order_id)
    request = OrdersGetRequest.new(order_id)
    response = PayPalClient.client.execute(request)
    response.result
  end

  def set_campaign
    @campaign = Campaign.friendly.find(params[:campaign_id])
  end
end

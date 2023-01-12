class Admin::DonationsController < AdminController
  DONATION_TYPES = { 'emergent' => 'emergent', 'squareup' => 'squareup payment' }.freeze

  before_action :set_donations, except: :export_donations

  def index
    respond_to do |format|
      format.html
      format.csv { send_data @donations.to_csv, filename: "donations-#{Date.today}.csv"}
    end
  end

  def get_donations
    respond_to do |format|
      format.js {render layout: false}
    end
  end

  def set_donations
    processor = params[:p]
    donations = Donation.order('created_at desc')
    donations = donations.paginate(page: params[:page], per_page: 20) unless request.format == 'csv'

    if DONATION_TYPES.keys.include?(processor)
      @donations = donations.where(via: DONATION_TYPES[processor])
    elsif processor == 'paypal'
      @donations = donations.joins(:paypal_payment_logs)
    end
    @total_interpay_donations = @donations.where(order_status: 'Successful').count if processor == 'interpay'
  end
end

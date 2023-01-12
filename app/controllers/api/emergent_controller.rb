class Api::EmergentController < ApiController
  CAMPAIGNS_LIMIT_DEFAULT = 5
  OK_STATUS = { status: 200, statusDescription: 'OK' }.freeze
  NOT_AUTHORIZED_STATUS = { status: 401, statusDescription: 'Not authorized' }.freeze
  PAYMENT_PARAMS = %i[payment_reference mobile_number amount].freeze
  rescue_from ActionController::ParameterMissing, with: :show_param_missing_error
  rescue_from EmergentException, with: :show_error

  before_action :authorize!
  before_action :set_campaign, only: %i[validate_campaign payment]

  def campaigns
    render json: campaigns_hash.merge(OK_STATUS)
  end

  def validate_campaign
    render json: campaign_hash.merge(OK_STATUS)
  end

  def payment
    return render_error('Invalid campaignCode') unless @campaign

    params.require(PAYMENT_PARAMS)
    EmergentPayment.call!(@campaign, params)
    render json: OK_STATUS
  end

  private

  # Note: this is an expensive operation since all published campaigns are being returned from the db
  def campaigns_hash
    # we only want to return the first n campaigns that are not full funded so instead of
    # iterating through the entire array (as in the commented out line below), let's
    # return immediately we have found n campaigns
    # campaigns = Campaign.published.order('RANDOM()').reject(&:fully_funded?).first(limit)
    campaigns = Campaign.published.order('RANDOM()').each_with_object([]) do |campaign, acc|
      break acc if acc.length == limit

      acc << campaign unless campaign.fully_funded?
    end
    { data: generate_campaigns_hash(campaigns) }
  end

  def limit
    @limit ||= params[:limit].blank? ? CAMPAIGNS_LIMIT_DEFAULT : [10, params[:limit].to_i].min
  end

  def generate_campaigns_hash(campaigns)
    campaigns.map { |campaign| { campaignCode: campaign.id.to_s, campaignName: campaign.campaign_name.truncate(65) } }
  end

  def campaign_hash
    if @campaign&.published && !@campaign&.fully_funded?
      { isValid: true, campaignName: @campaign.campaign_name }
    else
      { isValid: false }
    end
  end

  def authorize!
    render json: NOT_AUTHORIZED_STATUS unless valid_emergergent_credentials?
  end

  def show_param_missing_error(exception)
    render_error(exception.message.gsub(/: (.*)/, &:camelize)) # convert the param name from snake case to camel case
  end

  def show_error(exception)
    render_error(exception.message)
  end

  def render_error(message)
    render json: { status: 422, statusDescription: message }
  end

  def set_campaign
    params.require(:campaign_code)
    @campaign = Campaign.find_by(id: params[:campaign_code])
  end

  def valid_emergergent_credentials?
    params[:app_id] == ENV['EMERGENT_APP_ID'] && params[:app_key] == ENV['EMERGENT_APP_KEY']
  end
end

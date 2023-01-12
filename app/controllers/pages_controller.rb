class PagesController < ApplicationController
  before_action :fetch_campaigns,                     only:  [:campaigns]
  before_action :fetch_crowdfrica_campaign,           only:  [:generalfund]
  before_action :fetch_holday_campaign,               only:  [:holidays]

  def welcome
    @categories = Category.all.to_a
  end

  def about; end

  def campaigns
    respond_to do |format|
      format.html # campaigns.html.erb
      format.json { render json: @campaigns }
    end
  end

  def fetch_crowdfrica_campaign
    @crowdfrica = Campaign.find_by(campaign_name: 'crowdfrica campaign')
  end

  def fetch_holday_campaign
    @holiday = Campaign.find_by(campaign_name: 'holiday campaign')
  end

  def fetch_campaigns
    @campaigns = Campaign.where(published: true)
                         .order('created_at desc')
                         .paginate(page: params[:page], per_page: 12)
  end
end

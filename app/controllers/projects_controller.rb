class ProjectsController < ApplicationController
  before_action :address_by_request, :crowdfrica_campaign

  def index; end

  private

  def address_by_request
    @category = Category.find_by(slug: params[:category_id].to_s)
  end

  def crowdfrica_campaign
    @crowdfrica = Campaign.find_by(campaign_name: 'crowdfrica campaign')
  end
end

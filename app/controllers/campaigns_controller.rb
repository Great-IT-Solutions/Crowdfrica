class CampaignsController < ApplicationController
  before_action :set_campaign

  def show
    @championship = Championship.find_by(campaign_id: @campaign.id)
    @video_attachments = @campaign.project.project_description.embeds_attachments.select { |a| a.blob.video? }
    @donors = @campaign.project.donations.where(order_status: [nil, '', 'Successful']).pluck(:donor_id).uniq
    @total_donors = @campaign.project.donors.where(id: @donors).distinct.paginate(page: params[:page], per_page: 25)
    
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @campaign.project }
      format.js {render layout: false}
    end
  end

  def get_donors
    @donors = @campaign.project.donations.where(order_status: [nil, '', 'Successful']).pluck(:donor_id).uniq
    @total_donors = @campaign.project.donors.where(id: @donors).distinct.paginate(page: params[:page], per_page: 25)
    respond_to do |format|
      # format.json { render json: @total_donors }
      format.js {render layout: false}
    end
  end

  def thank_you; end

  private

  def set_campaign
    @campaign = Campaign.friendly.find(params[:id])
  end
end

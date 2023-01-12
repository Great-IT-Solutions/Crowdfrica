class Admin::CampaignsController < AdminController
  before_action :make_campaign_available_for, only: %i[edit update]

  def new
    @campaign = Campaign.new
  end

  def create
    @campaign = Campaign.new(campaign_params)
    if @campaign.save
      redirect_to admin_restricted_all_projects_path, notice: 'Campaign created succesfully'
    else
      flash.now[:alert] = 'Could not create campaign'
    end
  end

  def edit; end

  def update
    if @campaign.update(campaign_params)
      redirect_to admin_restricted_all_projects_path, notice: 'Campaign updated succesfully'
    else
      flash.now[:alert] = 'Could not update campaign'
      render :edit
    end
  end

  private

  def campaign_params
    params.require(:campaign).permit(:campaign_name,
                                     :campaign_headline,
                                     :campaign_image_url,
                                     :campaign_video_url,
                                     :published,
                                     :project_id)
  end

  def make_campaign_available_for
    @campaign = Campaign.friendly.find(params[:id])
  end
end

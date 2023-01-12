class ChampionshipRequestsController < ApplicationController
  def create
    @campaign = Campaign.friendly.find(params[:campaign_id])
    @championship_request = ChampionshipRequest.new(champ_request_params)
    @championship_request.campaign_id = @campaign.id
    @championship_request.champion_id = current_donor.id
    if @championship_request.save
      flash[:notice] = "Thank you #{current_donor.first_name}, someone is looking into your request."
      ChampionshipMailer.request_received(@championship_request).deliver_now
    else
      flash[:alert] = 'It looks like something went wrong'
    end
    redirect_to @campaign
  end

  private

  def champ_request_params
    params.require(:championship_request).permit(:reason, :relationship, :message, :declined)
  end
end

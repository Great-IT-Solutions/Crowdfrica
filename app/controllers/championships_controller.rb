class ChampionshipsController < ApplicationController
  before_action :find_donor_championship

  def edit; end

  def update
    @championship.update!(championship_params)
    flash[:notice] = 'Your changes were saved'
    redirect_to donor_path(current_donor)
  end

  def destroy
    @championship.destroy
    flash[:notice] = 'The Championship has been removed'
    redirect_to donor_path(current_donor)
  end

  private

  def find_donor_championship
    @championship = Championship.where(champion: current_donor).find(params[:id])
  end

  def championship_params
    params.require(:championship).permit(:message, :relationship, :champion_id, :campaign_id)
  end
end

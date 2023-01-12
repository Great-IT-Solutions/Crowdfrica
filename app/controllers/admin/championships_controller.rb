class Admin::ChampionshipsController < AdminController
  def index
    @championships = Championship.all.paginate(page: params[:page], per_page: 8)
  end

  def new
    @championship = Championship.new
  end

  def create # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    if params[:championship].key?(:championship_request_id)
      @champ_request = ChampionshipRequest.find(params[:championship][:championship_request_id])
      @championship = Championship.new(
        champion_id: @champ_request.champion_id,
        campaign_id: @champ_request.campaign_id,
        relationship: @champ_request.relationship,
        message: @champ_request.message
      )
    else
      @championship = Championship.new(championship_params)
    end

    if @championship.save
      decline_related_requests # the decline code looks strange and is untested
      @champ_request&.update_attribute('authorized', true) # rubocop:disable Rails/SkipsModelValidations
      @champ_request&.update_attribute('declined', false) # rubocop:disable Rails/SkipsModelValidations
      ChampionshipMailer.request_accepted(@championship).deliver_now
      redirect_to admin_championships_path, notice: 'A New Championship Was Created'
    elsif params[:championship].key?(:championship_request_id)
      redirect_to admin_championship_requests_path, alert: @championship.errors.full_messages.join(', ')
    else
      flash.now[:alert] = @championship.errors.full_messages.join(', ') if @championship.errors.any?
      render :new
    end
  end

  def edit
    @championship = Championship.find(params[:id])
  end

  def update
    @championship = Championship.find(params[:id])
    if @championship.update(championship_params)
      redirect_to admin_championships_path, notice: 'Your changes were saved'
    else
      flash[:alert] = @championship.errors.full_messages.join(', ') if @championship.errors.any?
      render 'edit'
    end
  end

  def destroy
    @championship = Championship.find(params[:id])
    @championship.destroy!
    redirect_to admin_championships_path, notice: 'The Championship has been removed.'
  end

  private

  def decline_related_requests
    ChampionshipRequest.where(champion_id: @championship.champion_id).or(ChampionshipRequest
                       .where(campaign_id: @championship.campaign_id)).update_all(declined: true) # rubocop:disable Rails/SkipsModelValidations
  end

  def championship_params
    params.require(:championship).permit(:message, :relationship, :champion_id, :campaign_id)
  end
end

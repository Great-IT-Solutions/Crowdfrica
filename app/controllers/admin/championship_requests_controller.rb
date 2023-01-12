class Admin::ChampionshipRequestsController < AdminController
  def index
    @championship_requests = ChampionshipRequest.where('authorized = ? AND declined = ?', false, false)
                                                .paginate(page: params[:page], per_page: 8)
  end

  def edit
    @championship_request = ChampionshipRequest.find(params[:id])
  end

  def update
    @championship_request = ChampionshipRequest.find(params[:id])
    if @championship_request.update(champ_request_params)
      flash[:notice] = 'The Championship Request has been updated'
    else
      flash.now[:notice] = 'The Championship Request was not updated'
      render 'index'
    end
    redirect_to admin_championship_requests_path
  end

  private

  def champ_request_params
    params.require(:championship_request).permit(:reason, :relationship, :message, :declined)
  end
end

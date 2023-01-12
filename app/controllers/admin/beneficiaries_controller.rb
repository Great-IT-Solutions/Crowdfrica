class Admin::BeneficiariesController < AdminController
  def new
    @beneficiary = Beneficiary.new
  end

  def create
    @beneficiary = Beneficiary.create(beneficiary_params)
    if @beneficiary.persisted?
      redirect_to new_admin_project_path(beneficiary: @beneficiary.id),
                  notice: "Create a project for #{@beneficiary.beneficiary_name}"
    else
      flash.now[:alert] = 'Could not add beneficiary'
      render :new
    end
  end

  def edit
    @beneficiary = Beneficiary.find(params[:id])
  end

  def update
    @beneficiary = Beneficiary.find(params[:id])
    if @beneficiary.update(beneficiary_params)
      redirect_to admin_restricted_all_projects_path, notice: 'Beneficiary has been successfully updated'
    else
      flash.now[:alert] = "Could not update #{@beneficiary.beneficiary_name} details"
      render :edit
    end
  end

  private

  def beneficiary_params
    params.require(:beneficiary).permit(:btype, :beneficiary_name, :country)
  end
end

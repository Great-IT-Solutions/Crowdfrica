class Admin::ProjectsController < AdminController
  before_action :set_project, only: %i[edit update destroy]

  def new
    @project = Project.new
    set_categories
  end

  def create
    @project = Project.new(project_params)
    if @project.save
      redirect_to admin_restricted_all_projects_path, notice: "#{@project.beneficiary.beneficiary_name}'s project has
                                                      been successfully created, create a campaign for the project now"
    else
      set_categories
      flash.now[:alert] = "Could not create #{@project.project_name}"
      render :new
    end
  end

  def edit
    set_categories
  end

  def update
    if @project.update(update_params)
      redirect_to admin_restricted_all_projects_path, notice: 'Project has been successfully updated'
    else
      set_categories
      flash.now[:alert] = "Could not update #{@project.project_name}"
      render :edit
    end
  end

  def destroy
    @project.destroy
    return unless @project.destroyed?

    redirect_to admin_restricted_all_projects_path, notice: "Successfully deleted #{@project.project_name}"
  end

  private

  def project_params
    params.require(:project).permit(:project_name, :project_description, :expires_at, :cost, :ailment_or_equipment,
                                    :date_funded, :beneficiary_id, :category_id, :year_cost, :medical_cost,
                                    :equipment_cost, :renewal, :processing, :operational_costs)
  end

  def update_params
    params.require(:project).permit(:project_name, :project_description, :expires_at, :cost, :medical_cost,
                                    :equipment_cost, :year_cost, :ailment_or_equipment, :date_funded, :category_id,
                                    :renewal, :processing, :operational_costs)
  end

  def set_categories
    @patient_category = Category.find_by(category_name: 'Patients')
    @insurance_category = Category.find_by(category_name: 'Health Insurance')
    @classroom_category = Category.find_by(category_name: 'Classroom Supplies')
  end

  def set_project
    @project = Project.friendly.find(params[:id])
  end
end

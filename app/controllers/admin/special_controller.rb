class Admin::SpecialController < AdminController
  #####################################################
  # This needs to be split up into separate controllers
  #####################################################

  def all_projects
    @projects = Project.order('created_at desc').paginate(page: params[:page], per_page: 8)
  end

  def all_categories
    @categories = Category.all
  end

  def preview
    @campaign = Campaign.friendly.find(params[:id])
  end

  def new_donation
    if (@campaign = Campaign.friendly.find_by(id: params[:new_donation][:project_id]))
      redirect_to new_donation_path(@campaign)
    else
      redirect_to admin_restricted_new_project_path, alert: 'Project Not Found !'
    end
  end

  def update_rate
    @rate = Exrate.first
    if @rate
      @rate.update!(rate_params)
      redirect_to admin_settings_path, notice: 'rate updated successfully'
    elsif (@rate = Exrate.create!(rate_params))
      redirect_to admin_settings_path, notice: 'rate created successfully'
    end
  end

  def project_donations
    @project = Project.friendly.find(params[:id])
    @donors = Project.friendly.find(params[:id]).donors.distinct
  end

  def all_blog_posts
    @posts = BlogPost.includes(:author).order('created_at desc').paginate(page: params[:page], per_page: 20)
  end

  private

  def rate_params
    params.require(:exchange_rate).permit(:rate, :ngn_rate, :kes_rate)
  end
end

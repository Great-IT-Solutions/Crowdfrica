class AdminController < ApplicationController
  layout 'admin'
  before_action :authenticate_admin_user!

  def index
    @projects = Project.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
  end
end

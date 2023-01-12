class DonorsController < ApplicationController
  before_action :find_donor, only: [:show]
  before_action :prevent_unauthorized_edit_to_profile, only: [:edit]

  private

  def prevent_unauthorized_edit_to_profile
    unless (current_donor == @donor) || current_donor.admin?
      render file: "#{Rails.root}/public/404.html", layout: false, status: :not_found
    end
  end

  def find_donor
    @donor = Donor.friendly.find(params[:id])
  end
end

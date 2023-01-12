class Donors::SessionsController < Devise::SessionsController
  include MixpanelHelper
  # before_action :configure_sign_in_params, only: [:create]

  # get /resource/sign_in
  # def new
  #   super
  # end

  # post /resource/sign_in
  def create
    resource = Donor.find_for_database_authentication(email: params[:donor][:email])
    return invalid_login_attempt unless resource

    if resource.valid_password?(params[:donor][:password])
      sign_in :donor, resource
      flash[:notice] = "Welcome #{resource.fullname}"
      mix_track(resource.id, 'Donor Log In')
      redirect_to root_path
    end

    invalid_login_attempt
 end

  # delete /resource/sign_out
  # def destroy
  #  super
  # end

  # protected

  # if you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
  # passess the donor id to welcome page for it to be saved in a meta tag
  def after_sign_in_path_for(resource)
    root_path mpi: resource.id
  end

  # def after_sign_out_path_for(resource)
  #   root_path
  # end
  protected

  def invalid_login_attempt
    respond_to do |format|
      format.js
    end
  end
end

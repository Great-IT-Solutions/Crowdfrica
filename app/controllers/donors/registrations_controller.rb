class Donors::RegistrationsController < Devise::RegistrationsController
  # infilterate here with application controller
  require 'application_controller'
  include MixpanelHelper
  before_action :configure_sign_up_params, only: [:create]
  after_action  :update_donor_status!,     only: [:create]
  before_action :configure_account_update_params, only: [:update]

  # we do not use this route since we have a pop-up for signup
  def new
    render file: Rails.root.join('public/404.html'), status: :not_found, layout: false
  end

  # POST /resource
  def create
    build_resource(sign_up_params)
    if resource.save
      create_mixpanel_user(resource.id, params[:mixId], 'Donor Sign Up', {
                             'Full Name' => resource.fullname,
                             '$email' => resource.email,
                             'Donor ID' => resource.id
                           })
      if resource.active_for_authentication?
        set_flash_message :notice, :signed_up if is_navigational_format?
        sign_up(resource_name, resource)
        flash[:notice] = "Signed Up. Welcome #{resource.fullname}"
      else
        set_flash_message :notice, :"signed_up_but_#{resource.inactive_message}" if is_navigational_format?
        expire_session_data_after_sign_in!
      end
      redirect_to root_path
    else
      clean_up_passwords resource
      @errors = resource.errors.full_messages
      respond_to do |format|
        format.js
      end
    end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  def update
    account_update_params = devise_parameter_sanitizer.sanitize(:account_update)
    @donor = Donor.find(current_donor.id)

    if @donor.is_authenticated_from_facebook?
      if params[:donor][:password].blank?
        account_update_params.delete('password')
        account_update_params.delete('password_confirmation')
      end
      account_update_params.delete('current_password')
      successfully_updated = @donor.update(account_update_params)
    else
      successfully_updated = @donor.update_with_password(account_update_params)
    end

    if successfully_updated
      set_flash_message :notice, :updated
      redirect_to edit_donor_registration_path
    else
      render 'edit'
    end
  end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  protected

  # If you have extra params to permit, append them to the sanitizer.
  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[attribute fullname gender country phone])
  end

  # If you have extra params to permit, append them to the sanitizer.
  def configure_account_update_params
    devise_parameter_sanitizer.permit(:account_update, keys: %i[attribute fullname gender country phone])
  end

  # The path used after sign up.
  def after_sign_up_path_for(_resource)
    root_path
  end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  def update_donor_status!
    return unless resource.persisted?

    # resource.toggle!(:registered)
    resource.update(registered: true, color: color_gen)
  end
end

class Donors::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    auth = request.env['omniauth.auth']
    @donor = Donor.from_omniauth(auth)
    if @donor.persisted?
      if @donor.provider.nil?
        @donor.update(provider: auth.provider, uid: auth.uid, image: auth.info.image, registered: true)
      end
      sign_in_and_redirect @donor, event: :authentication
      set_flash_message(:notice, :success, kind: 'Facebook') if is_navigational_format?
    else
      session['devise.facebook_data'] = request.env['omniauth.auth']
      redirect_to root_path
    end
  end

  def failure
    redirect_to root_path
  end
end

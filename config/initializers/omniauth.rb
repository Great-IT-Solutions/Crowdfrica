Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV['FB_APP_ID'], ENV['FB_SECRET_KEY'],
           callback_url: ENV['FB_CALL_BACK_URL'],
           secure_image_url: true,
           client_options: {
             site: 'https://graph.facebook.com/v7.0',
             authorize_url: 'https://www.facebook.com/v7.0/dialog/oauth'
           }
end

CountrySelect::FORMATS[:with_country_code] = lambda do |country|
  "#{country.name} (+#{country.country_code})"
end

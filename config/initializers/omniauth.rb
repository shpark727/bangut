OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, ENV["facebook_app_id"], ENV["facebook_app_secret"],
 	:scope => 'email,user_birthday,public_profile,user_about_me'
end

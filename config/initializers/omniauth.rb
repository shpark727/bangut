OmniAuth.config.logger = Rails.logger

Rails.application.config.middleware.use OmniAuth::Builder do
  provider :facebook, '929164573846483', '1c17c31d90c00b27e3ef2079bbcab858',
 	{:scope => 'email,user_birthday,public_profile,user_about_me,read_stream'}
end

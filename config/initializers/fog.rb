

CarrierWave.configure do |config|
#  config.fog_provider = 'fog/aws'                        # required
	config.fog_credentials = {
	  provider:              'AWS',                        # required
	  aws_access_key_id:     'AKIAIKGLIXQV2ISXSUNQ',                        # required
	  aws_secret_access_key: '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',                        # required
	  region:                'ap-northeast-1'                  # optional, defaults to 'us-east-1'

	 }
	  config.fog_directory  = 'campuswanted'                          # required

end

class User < ActiveRecord::Base
    self.table_name = 'user'
	#	mount_uploader :profile_img, S3uploaderUploader

		has_many :image_pools, :class_name => 'ImagePool'
    has_many :wanted_boards, :class_name => 'WantedBoard'
    has_many :wanted_comments, :class_name => 'WantedComment'
    has_many :withdraws, :class_name => 'Withdraw'
		has_many :pay_log, :class_name => 'PayLog'
 
		has_one :token, :class_name => 'Token'
		has_one :device
		
end

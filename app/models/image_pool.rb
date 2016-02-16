class ImagePool < ActiveRecord::Base
    self.table_name = 'image_pool'
	mount_uploader :path, S3uploaderUploader



    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
   # has_many :users, :class_name => 'User'
end

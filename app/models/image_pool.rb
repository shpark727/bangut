class ImagePool < ActiveRecord::Base
    self.table_name = 'image_pool'


    has_many :users, :class_name => 'User'
     mount_uploader :path, S3uploaderUploader 
end

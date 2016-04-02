class DrawPool < ActiveRecord::Base
    self.table_name = 'draw_pool'
	mount_uploader :path, S3uploaderUploader



    belongs_to :wanted_board, :class_name => 'WantedBoard', :foreign_key => :post_id
end

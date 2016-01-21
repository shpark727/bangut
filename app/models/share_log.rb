class ShareLog < ActiveRecord::Base
    self.table_name = 'share_log'


    belongs_to :wanted_board, :class_name => 'WantedBoard', :foreign_key => :post_id
end

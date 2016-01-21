class WantedComment < ActiveRecord::Base
    self.table_name = 'wanted_comment'


    belongs_to :wanted_board, :class_name => 'WantedBoard', :foreign_key => :post_id
    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
end

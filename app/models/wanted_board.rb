class WantedBoard < ActiveRecord::Base
    self.table_name = 'wanted_board'


    has_many :share_logs, :class_name => 'ShareLog'
    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
    belongs_to :univ_category, :class_name => 'UnivCategory', :foreign_key => :univ_id
    has_many :wanted_comments, :class_name => 'WantedComment'
		
		has_one :draw_pool, :class_name => 'DrawPool'
		

end

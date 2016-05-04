class PayLog < ActiveRecord::Base
    self.table_name = 'pay_log'
	
		belongs_to :user, :class_name => 'User' , :foreign_key => :user_id
		belongs_to :wanted_board, :class_name => 'WantedBoard', :foreign_key => :post_id	
		belongs_to :reward_item, :class_name => 'RewardItem', :foreign_key => :item_id

		

end

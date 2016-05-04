class RewardItem < ActiveRecord::Base
    self.table_name = 'reward_item'
	
    has_many :pay_log, :class_name => 'PayLog'
		


end

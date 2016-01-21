class Withdraw < ActiveRecord::Base
    self.table_name = 'withdraw'


    belongs_to :user, :class_name => 'User', :foreign_key => :user_id
    belongs_to :bank, :class_name => 'Bank', :foreign_key => :bank_id
end

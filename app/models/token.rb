class Token < ActiveRecord::Base
    self.table_name = 'token'


	  belongs_to :user, :class_name => 'User', :foreign_key => :user_id

end

class PushFeedback < ActiveRecord::Base
    self.table_name = 'push_feedback'

    self.inheritance_column = :ruby_type
end

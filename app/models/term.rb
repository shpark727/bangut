class Term < ActiveRecord::Base
    self.table_name = 'term'
    self.primary_key = :term_code

end

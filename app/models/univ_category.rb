class UnivCategory < ActiveRecord::Base
    self.table_name = 'univ_category'


    has_many :wanted_boards, :class_name => 'WantedBoard'
end

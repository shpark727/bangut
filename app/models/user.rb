class User < ActiveRecord::Base
    self.table_name = 'user'


    belongs_to :image_pool, :class_name => 'ImagePool', :foreign_key => :profile_img
    has_many :wanted_boards, :class_name => 'WantedBoard'
    has_many :wanted_comments, :class_name => 'WantedComment'
    has_many :withdraws, :class_name => 'Withdraw'
end

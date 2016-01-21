class Bank < ActiveRecord::Base



    has_many :withdraws, :class_name => 'Withdraw'
end

class Device < ActiveRecord::Base
	belongs_to :user
	validates :uuid, presence: true, uniqueness: true
end

class Page < ActiveRecord::Base
	acts_as_votable
	belongs_to :upload
	has_many :comments
end

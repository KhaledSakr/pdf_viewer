class Upload < ActiveRecord::Base
	acts_as_votable
	has_many :comments
  has_attached_file :document, dependent: :destroy
	validates_attachment :document, :content_type => {:content_type => %w(image/jpeg image/jpg image/png application/pdf application/msword application/vnd.openxmlformats-officedocument.wordprocessingml.document)}
end
 
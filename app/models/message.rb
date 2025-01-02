class Message < ApplicationRecord
	belongs_to :user
	belongs_to :room
	# validates :body, presence: true
  	has_one_attached :media_file

  	# def thumbnail
  	# 	self.media_file.variant(resize: "300x300")
  	# end

end

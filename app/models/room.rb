class Room < ApplicationRecord
	validates :name, presence: { message: "should be present" }
	validates :topic_name, presence: { message: "should be present" }
	belongs_to :user
	belongs_to :topic
  	has_many :messages, dependent: :destroy
  	has_many :users, through: :messages


  	searchkick text_middle: %i[:name :description]

  	self.per_page = 5

	# before_save :set_topic_name
	attr_accessor :topic_name


	def host
		user = User.find(self.user_id)
	end

	def topic
		topic_name = Topic.find(self.topic_id)
	end



	# searchkick text_middle: %i[name description topic]


	# def set_topic_name
	# 	tmp = Topic.find_by_name(topic_name)
	# 	if tmp
	# 		self.topic_id = tmp.id
	# 	end
	# end

end

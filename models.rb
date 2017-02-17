class User < ActiveRecord::Base
	has_many :posts
end 

class Post < ActiveRecord::Base
	validates_length_of :body, maximum: 150
	belongs_to :user 
end 
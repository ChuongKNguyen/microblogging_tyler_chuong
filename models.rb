class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
end 

class Post < ActiveRecord::Base
	validates_length_of :body, maximum: 150
	belongs_to :user 
end 
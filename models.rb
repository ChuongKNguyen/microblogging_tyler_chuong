class User < ActiveRecord::Base

end 

class Post < ActiveRecord::Base
	validates_length_of :body, maximum: 150
end 
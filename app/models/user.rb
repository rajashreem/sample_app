class User < ActiveRecord::Base
	attr_accessible :name, :email
	regex = /\A[\w+\-.]+@[a-z\-\d.]+\.[a-z]+\z/i
	
	validates :name, :presence => true,
				:length => {:maximum => 50}
					

	validates :email, :presence => true,
				:format=> {:with => regex},
				:uniqueness => {:case_sensitive => false}
end

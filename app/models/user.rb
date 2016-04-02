class User < ActiveRecord::Base
	has_secure_password
	has_many :goals
	validates_uniqueness_of :email
	validates_presence_of :email, :first_name, :last_name, :country
end

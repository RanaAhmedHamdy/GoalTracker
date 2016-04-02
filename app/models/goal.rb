class Goal < ActiveRecord::Base
	belongs_to :user
	validates_presence_of :title, :description, :start_date, :end_date
end

class Course < ActiveRecord::Base
	has_many :tutors
	validates :name, presence: true, uniqueness: { case_sensitive: false, message: "This course already exists!" }
end

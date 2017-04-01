class Attendance < ApplicationRecord
  belongs_to :developer
  def self.create_objects
  	developers = Developer.all
  	developers.each_with_index do |obj, index|
  		p obj
  	end
  end
end

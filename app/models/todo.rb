class Todo < ApplicationRecord
	belongs_to :project
	belongs_to :developer
	validates_presence_of :task_name, :task_time

	scope :research, -> {
		where(:task_type => "Research")
	}

	scope :task, -> {
		where(:task_type => "Task")
	}

end

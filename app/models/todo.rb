class Todo < ApplicationRecord
	belongs_to :project
	belongs_to :developer
	has_many :dsr_replies , dependent: :destroy
	validates_presence_of :task_name, :task_time
	enum task_type:["Task","Research"]
	scope :research, -> {
		where(:task_type => "Research")
	}

	scope :task, -> {
		where(:task_type => "Task")
	}

end

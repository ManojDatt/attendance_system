class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :developer
  # enum task_status:["Pending","Complete"]
   # enum task_type: { Task: 0, Research: 1 }

scope :research, -> {
  where(:task_type => "Research")
}

scope :task, -> {
  where(:task_type => "Task")
}


end

class Todo < ApplicationRecord
  belongs_to :project
  belongs_to :developer
  # enum task_status:["Pending","Complete"]
   enum task_type:["Task","Research"]

end

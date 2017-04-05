class ApplyLeave < ApplicationRecord
  belongs_to :developer
  enum status:[:Pending,:Approved,:Rejected]
end

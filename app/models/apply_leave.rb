class ApplyLeave < ApplicationRecord
  belongs_to :developer
  enum status:[:Pending,:Approved,:Rejected]
  enum leave_type:[:Paid,:Unpaid]
  validates :leave_type, presence: true
end

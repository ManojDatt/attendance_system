class AddLeaveTypeToApplyLeaves < ActiveRecord::Migration[5.0]
  def change
    add_column :apply_leaves, :leave_type, :integer
  end
end

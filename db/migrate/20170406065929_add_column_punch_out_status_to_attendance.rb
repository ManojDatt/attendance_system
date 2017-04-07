class AddColumnPunchOutStatusToAttendance < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendances, :punch_out_status, :boolean, default: false
  end
end

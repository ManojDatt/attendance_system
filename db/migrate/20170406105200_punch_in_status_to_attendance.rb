class PunchInStatusToAttendance < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendances, :punch_in_status, :boolean, default: false
  end
end

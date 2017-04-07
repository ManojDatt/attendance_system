class AddColumnPunchInTimePunchOutTimeToAttendance < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendances, :punch_in_at, :float, default: 10
  	add_column :attendances, :punch_out_at, :float, default: 19
  	add_column :attendances, :is_hollyday, :boolean, default: false
  end
end

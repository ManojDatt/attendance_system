class AddColumnWeekOOfToAttendance < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendances, :week_off, :boolean, default: false
  end
end

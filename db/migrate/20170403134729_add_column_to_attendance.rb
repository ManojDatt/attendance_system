class AddColumnToAttendance < ActiveRecord::Migration[5.0]
  def change
    add_column :attendances, :extra_work, :string
    add_column :attendances, :work_hour, :string
    add_column :attendances, :lat_in, :timestamp
    add_column :attendances, :early_out, :timestamp
  end
end

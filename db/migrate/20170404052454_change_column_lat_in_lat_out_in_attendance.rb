class ChangeColumnLatInLatOutInAttendance < ActiveRecord::Migration[5.0]
  def change
  	remove_column :attendances, :lat_in
  	remove_column :attendances, :lat_out
  	add_column :attendances, :work_hour, :string
    add_column :attendances, :lat_in, :timestamp
    add_column :attendances, :early_out, :timestamp
  end
end

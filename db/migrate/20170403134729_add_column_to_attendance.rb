class AddColumnToAttendance < ActiveRecord::Migration[5.0]
  def change
    add_column :attendances, :extra_work, :string
    add_column :attendances, :lat_in, :boolean, default: false
    add_column :attendances, :lat_out, :boolean, default: false
  end
end

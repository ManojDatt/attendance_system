class EarlyOutChangeColumnToAttendance < ActiveRecord::Migration[5.0]
  def change
  	change_column :attendances, :early_out, :string
  end
end

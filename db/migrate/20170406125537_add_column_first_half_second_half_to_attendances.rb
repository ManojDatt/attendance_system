class AddColumnFirstHalfSecondHalfToAttendances < ActiveRecord::Migration[5.0]
  def change
  	add_column :attendances, :first_half, :boolean
  	add_column :attendances, :second_half, :boolean
  end
end

class CreateAttendances < ActiveRecord::Migration[5.0]
  def change
    create_table :attendances do |t|
      t.references :developer, foreign_key: true
      t.timestamp :punch_in_time
      t.timestamp :punch_out_time

      t.timestamps
    end
  end
end

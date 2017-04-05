class CreateApplyLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :apply_leaves do |t|
      t.float :total_leave
      t.date :start_date
      t.date :end_date
      t.text :reason
      t.integer :status
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end

class CreateLeaves < ActiveRecord::Migration[5.0]
  def change
    create_table :leaves do |t|
      t.float :total_leave
      t.float :available_leave
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end

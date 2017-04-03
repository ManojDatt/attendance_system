class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :task_name
      t.string :task_time
      t.integer :task_type
      t.integer :task_status
      t.references :project, foreign_key: true
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end

class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :task_name
      t.string :task_time
      t.string :task_type
      t.string :remark
      t.references :project, foreign_key: true
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end

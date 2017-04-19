class AddColumnIsActiveToDeveloper < ActiveRecord::Migration[5.0]
  def change
    add_column :developers, :is_locked, :boolean, default: false
  end
end

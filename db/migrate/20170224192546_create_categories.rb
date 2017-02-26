class CreateCategories < ActiveRecord::Migration[5.0]
  def change
    create_table :categories, id: false do |t|
      t.primary_key :pkcategory
      t.text :description
      t.text :note

      t.timestamps
    end
    add_index :categories, :pkcategory, unique: true
  end
end

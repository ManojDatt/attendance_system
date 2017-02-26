class CreateServices < ActiveRecord::Migration[5.0]
  def change
    create_table :services, id: false do |t|
      t.primary_key :pkservice
      t.text :description
      t.text :notes

      t.timestamps
    end
    add_index :services, :pkservice, unique: true
  end
end

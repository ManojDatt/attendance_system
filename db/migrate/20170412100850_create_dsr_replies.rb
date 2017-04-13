class CreateDsrReplies < ActiveRecord::Migration[5.0]
  def change
    create_table :dsr_replies do |t|
      t.references :todo, foreign_key: true
      t.text :message

      t.timestamps
    end
  end
end

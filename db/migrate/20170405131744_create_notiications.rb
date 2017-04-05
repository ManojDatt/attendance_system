class CreateNotiications < ActiveRecord::Migration[5.0]
  def change
    create_table :notiications do |t|
      t.string :message
      t.boolean :unseen, default: true
      t.string :notification_type
      t.references :developer, foreign_key: true

      t.timestamps
    end
  end
end

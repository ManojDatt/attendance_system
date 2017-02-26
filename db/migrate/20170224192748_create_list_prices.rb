class CreateListPrices < ActiveRecord::Migration[5.0]
  def change
    create_table :list_prices , id: false do |t|
      t.primary_key :pklist
      t.boolean :list_default_mark
      t.string :list_description

      t.timestamps
    end
    add_index :list_prices, :pklist, unique: true
  end
end

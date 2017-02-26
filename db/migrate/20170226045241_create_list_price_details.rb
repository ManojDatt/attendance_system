class CreateListPriceDetails < ActiveRecord::Migration[5.0]
  def change
    create_table :list_price_details do |t|
      t.string :listprice
      t.references :category, foreign_key: true
      t.references :service, foreign_key: true
      t.references :list_price, foreign_key: true

      t.timestamps
    end
  end
end

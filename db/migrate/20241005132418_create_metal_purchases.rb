class CreateMetalPurchases < ActiveRecord::Migration[7.0]
  def change
    create_table :metal_purchases do |t|
      t.references :metal, null: false, foreign_key: true
      t.date :purchase_date
      t.decimal :purchase_quantity
      t.decimal :price
      t.string :supplier

      t.timestamps
    end
  end
end

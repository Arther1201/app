class CreateSupplies < ActiveRecord::Migration[7.0]
  def change
    create_table :supplies do |t|
      t.string :category
      t.string :item_name
      t.date :order_date
      t.integer :order_quantity
      t.date :delivery_date

      t.timestamps
    end
  end
end

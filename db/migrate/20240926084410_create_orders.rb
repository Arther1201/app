class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :supply, null: false, foreign_key: true
      t.date :order_date
      t.date :delivery_date
      t.integer :order_quantity

      t.timestamps
    end
  end
end

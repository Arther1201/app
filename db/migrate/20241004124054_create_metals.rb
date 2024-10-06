class CreateMetals < ActiveRecord::Migration[7.0]
  def change
    create_table :metals do |t|
      t.string :name
      t.date :purchase_date
      t.date :consumption_date
      t.string :consumption_place
      t.decimal :remaining_quantity
      t.decimal :purchase_quantity

      t.timestamps
    end
  end
end

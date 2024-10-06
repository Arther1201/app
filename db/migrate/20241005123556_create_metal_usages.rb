class CreateMetalUsages < ActiveRecord::Migration[7.0]
  def change
    create_table :metal_usages do |t|
      t.references :metal, null: false, foreign_key: true
      t.string :department
      t.date :used_date
      t.decimal :used_quantity

      t.timestamps
    end
  end
end

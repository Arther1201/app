class CreateSupplyArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :supply_archives do |t|
      t.integer :year, null: false
      t.text :archived_data, null: false

      t.timestamps
    end
  end
end

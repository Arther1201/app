class ChangeMetalAmountTypeInPatients < ActiveRecord::Migration[7.0]
  def change
    change_column :patients, :metal_amount, :decimal, precision: 5, scale: 2
  end
end

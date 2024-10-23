class ChangeMetalAmountType < ActiveRecord::Migration[7.0]
  def change
    change_column :patients, :metal_amount, :decimal, precision: 10, scale: 2
  end
end

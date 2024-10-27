class AddInventoryFieldsToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :last_year_stock, :integer
    add_column :supplies, :current_year_stock, :integer
    add_column :supplies, :consumption, :integer
  end
end

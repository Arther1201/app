class AddSuppliesAllQuantityToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :supplies_all_quantity, :integer
  end
end

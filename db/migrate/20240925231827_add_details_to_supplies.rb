class AddDetailsToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :manufacturer, :string
    add_column :supplies, :price, :decimal
    add_column :supplies, :stock_quantity, :integer
  end
end

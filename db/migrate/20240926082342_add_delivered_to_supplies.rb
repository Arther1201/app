class AddDeliveredToSupplies < ActiveRecord::Migration[7.0]
  def change
    add_column :supplies, :delivered, :boolean
  end
end

class AddPriceToMetals < ActiveRecord::Migration[7.0]
  def change
    add_column :metals, :price, :decimal
  end
end

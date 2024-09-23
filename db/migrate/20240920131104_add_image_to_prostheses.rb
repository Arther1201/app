class AddImageToProstheses < ActiveRecord::Migration[7.0]
  def change
    add_column :prostheses, :image, :string
  end
end

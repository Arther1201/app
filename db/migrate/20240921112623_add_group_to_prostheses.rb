class AddGroupToProstheses < ActiveRecord::Migration[7.0]
  def change
    add_column :prostheses, :group, :string
  end
end

class RemoveUpperStructureFromPatients < ActiveRecord::Migration[7.0]
  def change
    remove_column :patients, :upper_structure, :string
  end
end

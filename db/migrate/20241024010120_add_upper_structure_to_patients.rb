class AddUpperStructureToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :upper_structure, :string
  end
end

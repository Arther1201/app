class AddAdditionalOptionToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :additional_option, :string
  end
end

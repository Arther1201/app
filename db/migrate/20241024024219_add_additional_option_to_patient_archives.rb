class AddAdditionalOptionToPatientArchives < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_archives, :additional_option, :string
  end
end

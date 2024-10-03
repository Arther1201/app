class AddPatientIdToPatientArchives < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_archives, :patient_id, :integer
  end
end

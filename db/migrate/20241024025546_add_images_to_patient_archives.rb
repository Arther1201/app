class AddImagesToPatientArchives < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_archives, :images, :json
  end
end

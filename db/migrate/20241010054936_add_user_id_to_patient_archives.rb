class AddUserIdToPatientArchives < ActiveRecord::Migration[7.0]
  def change
    add_column :patient_archives, :user_id, :integer
  end
end

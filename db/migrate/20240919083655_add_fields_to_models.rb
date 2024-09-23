class AddFieldsToModels < ActiveRecord::Migration[7.0]
  def change
    add_column :models, :impression_date, :date
    add_column :models, :medical_record_number, :string
    add_column :models, :patient_name, :string
    add_column :models, :storage_location, :string
  end
end

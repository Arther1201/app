class CreatePatientArchives < ActiveRecord::Migration[7.0]
  def change
    create_table :patient_archives do |t|
      t.string :name
      t.string :medical_record_number
      t.date :impression_date
      t.string :prosthesis_type_insurance
      t.string :prosthesis_type_crown
      t.string :prosthesis_type_denture
      t.string :upper_left
      t.string :upper_right
      t.string :lower_left
      t.string :lower_right
      t.decimal :metal_amount
      t.string :requester
      t.string :trial_or_set
      t.date :set_date
      t.boolean :note_checked
      t.boolean :delivery_checked
      t.integer :archived_year

      t.timestamps
    end
  end
end

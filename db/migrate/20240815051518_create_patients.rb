class CreatePatients < ActiveRecord::Migration[7.0]
  def change
    create_table :patients do |t|
      t.date :impression_date
      t.boolean :note_checked
      t.string :medical_record_number
      t.string :name
      t.string :gender
      t.string :prosthesis_type
      t.string :prosthesis_site
      t.string :metal_type
      t.decimal :metal_amount
      t.string :trial_or_set
      t.date :set_date
      t.boolean :delivery_checked
      t.text :memo
      t.string :medicine_notebook
      t.string :image

      t.timestamps
    end
  end
end

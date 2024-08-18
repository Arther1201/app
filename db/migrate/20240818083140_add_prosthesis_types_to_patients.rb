class AddProsthesisTypesToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :prosthesis_type_insurance, :string
    add_column :patients, :prosthesis_type_crown, :string
    add_column :patients, :prosthesis_type_denture, :string
  end
end

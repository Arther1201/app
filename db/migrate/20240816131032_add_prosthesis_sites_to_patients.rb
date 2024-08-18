class AddProsthesisSitesToPatients < ActiveRecord::Migration[7.0]
  def change
    add_column :patients, :prosthesis_sites, :text
  end
end
